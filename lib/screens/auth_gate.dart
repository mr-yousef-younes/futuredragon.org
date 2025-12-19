//auth_gate.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth_service.dart';
import '../widgets/theme_toggle.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final authState = await AuthService.checkAuthState();

    if (!mounted) return;
    switch (authState) {
      case AuthState.signedInWithCompleteProfile:
        context.go('/home');
        break;
      case AuthState.signedInButIncompleteProfile:
      case AuthState.signedInButNoProfile:
        context.push('/create');
        break;
      default:
        break;
    }
  }


  Future<void> _signInWithGoogle() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final result = await AuthService.signInWithGoogle();

    if (result == "success") {
      await _checkAuthState();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), backgroundColor: Colors.red),
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' مرحباً بك معنا',
                          style: theme.textTheme.titleLarge,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.9)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _signInWithGoogle,
                          child: Text(
                            _isLoading
                                ? 'تسجيل الدخول....'
                                : ' تسجيل دخول سريع',
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            side: BorderSide(
                              color: theme.colorScheme.primary,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _isLoading
                              ? null
                              : () => context.push('/email-login'),
                          icon: const Icon(Icons.email_outlined, size: 22),
                          label: const Text(
                            'تسجيل بواسطة البريد الإلكتروني',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const ThemeToggle(),
                        TextButton(
                          onPressed: () => context.push('/privacy'),
                          child: const Text(
                            "سياسة الخصوصية",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withAlpha((0.5 * 255).round()),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

