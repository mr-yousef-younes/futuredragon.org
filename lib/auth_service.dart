//auth_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class AuthService {
  static bool _isInitialized = false;
  static const _keyAuthProvider = 'auth_provider';

  static Future<void> initializeGoogleSignIn() async {
    if (!_isInitialized && !kIsWeb) {
      await GoogleSignIn.instance.initialize();
    }
    _isInitialized = true;
  }

  static Future<String> signInWithGoogle() async {
    try {
      await initializeGoogleSignIn();
      UserCredential userCred;

      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCred = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount authResult = await GoogleSignIn.instance
            .authenticate();
        final googleAuth = authResult.authentication;
        if (googleAuth.idToken == null) {
          return "فشل في الحصول على token المصادقة";
        }

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      }

      if (userCred.user != null) {
        await _saveUserToFirestore(userCred.user!);
        await _saveUserLocally(userCred.user!);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_keyAuthProvider, 'google');
        return "success";
      }

      return "فشل تسجيل الدخول";
    } on FirebaseAuthException catch (e) {
      return _mapAuthError(e);
    } catch (e) {
      return "❌ خطأ غير متوقع: $e";
    }
  }

  static Future<String> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyAuthProvider, 'email');

      return "success";
    } on FirebaseAuthException catch (e) {
      return _mapAuthError(e);
    } catch (e) {
      return "❌ خطأ أثناء تسجيل الدخول بالبريد: $e";
    }
  }

  static Future<AuthState> checkAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user = FirebaseAuth.instance.currentUser;
      final provider = prefs.getString(_keyAuthProvider);

      // التحقق المبدئي من تسجيل الدخول
      if (user == null || provider == null) {
        return AuthState.notSignedIn;
      }

      // جلب بيانات المستخدم من Firestore
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (!doc.exists) {
        return AuthState.signedInButNoProfile;
      }
      final data = doc.data() ?? {};

      final hasCompleteProfile =
          (data['firstName'] != null &&
              data['firstName'].toString().isNotEmpty) &&
          (data['lastName'] != null &&
              data['lastName'].toString().isNotEmpty) &&
          (data['gender'] != null && data['gender'].toString().isNotEmpty) &&
          (data['country'] != null && data['country'].toString().isNotEmpty) &&
          (data['currency'] != null && data['currency'].toString().isNotEmpty);

      if (hasCompleteProfile) {
        return AuthState.signedInWithCompleteProfile;
      } else {
        return AuthState.signedInButIncompleteProfile;
      }
    } catch (e) {
      debugPrint("❌ خطأ في checkAuthState(): $e");
      return AuthState.error;
    }
  }

  static Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final provider = prefs.getString(_keyAuthProvider);

      await FirebaseAuth.instance.signOut();
      if (provider == 'google' && !kIsWeb) {
        await GoogleSignIn.instance.signOut();
      }
      await prefs.clear();
    } catch (_) {}
  }

 static Future<String> createAccount({
  required String firstName,
  required String lastName,
  required String gender,
  required String country,
  required String currency,
  required String birthDate,
  required String email,
  required String password,
}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    // لو المستخدم مش موجود (تسجيل بالبريد لأول مرة)
    if (user == null) {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      user = credential.user;
      if (user == null) return "لم يتم إنشاء المستخدم";
    }

    // حفظ البيانات في Firestore
    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "firstName": firstName,
      "lastName": lastName,
      "fullName": "$firstName $lastName",
      "gender": gender,
      "country": country,
      "currency": currency,
      "email": user.email ?? email,
      "birthDate": birthDate,
      "photoURL": user.photoURL,
      "displayName": user.displayName,
      "createdAt": FieldValue.serverTimestamp(),
      "lastLogin": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // حفظ محلي
    await _saveUserLocally(user);

    // حفظ نوع الحساب في SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAuthProvider, 'email');

    return "success";
  } on FirebaseAuthException catch (e) {
    return _mapAuthError(e);
  } catch (e) {
    return "❌ خطأ في إنشاء الحساب: $e";
  }
}


  static Future<bool> checkIfUserExists() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('hasAccount') ?? false;
    }
    return true;
  }

  static Future<bool> hasCompleteProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (!doc.exists) return false;

      final data = doc.data()!;
      return data.containsKey('firstName') &&
          data.containsKey('lastName') &&
          data.containsKey('gender') &&
          data.containsKey('country') &&
          data.containsKey('currency');
    } catch (_) {
      return false;
    }
  }

  static User? getCurrentUser() => FirebaseAuth.instance.currentUser;

  static Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  static Future<List<String>> loadCountries() async {
    try {
      final response = await rootBundle.loadString(
        'assets/data/countries.json',
      );
      final data = json.decode(response) as List<dynamic>;
      return data.map((e) => e.toString()).toList();
    } catch (_) {return ['مصر','السعودية','الإمارات','الكويت','قطر','البحرين','عمان','الأردن','لبنان','سوريا','العراق','اليمن','المغرب','الجزائر','تونس','ليبيا','السودان','الولايات المتحدة','كندا','المملكة المتحدة','فرنسا','ألمانيا','إيطاليا','إسبانيا','الصين','اليابان','الهند',];}}

  static Future<void> _saveUserToFirestore(User user) async {
    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "photoURL": user.photoURL,
      "displayName": user.displayName,
      "createdAt": FieldValue.serverTimestamp(),
      "lastLogin": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "تم إرسال رابط إعادة التعيين إلى البريد الإلكتروني";
    } on FirebaseAuthException catch (e) {
      return _mapAuthError(e);
    } catch (_) {
      return "حدث خطأ أثناء إعادة تعيين كلمة المرور";
    }
  }

  static Future<void> _saveUserLocally(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', user.email ?? '');
    await prefs.setBool('hasAccount', true);
    await prefs.setString('userId', user.uid);
  }

  static String _mapAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'الحساب غير موجود، يرجى إنشاء حساب جديد';
    case 'wrong-password':
      return 'كلمة المرور غير صحيحة';
    case 'invalid-email':
      return 'البريد الإلكتروني غير صالح';
    case 'user-disabled':
      return 'تم تعطيل هذا الحساب';
    case 'too-many-requests':
      return 'تم حظر المحاولة مؤقتاً، يرجى المحاولة لاحقاً';
    case 'email-already-in-use':
      return 'البريد الإلكتروني مستخدم بالفعل';
    case 'weak-password':
      return 'كلمة المرور ضعيفة جداً';
    default:
      return e.message ?? 'حدث خطأ غير متوقع';
  }
}


  static Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (!doc.exists) return null;

      return doc.data();
    } catch (_) {
      return null;
    }
  }
}

enum AuthState {
  notSignedIn,
  signedInButNoProfile,
  signedInButIncompleteProfile,
  signedInWithCompleteProfile,
  error,
}
