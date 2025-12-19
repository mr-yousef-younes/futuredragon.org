import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../widgets/password_field.dart';
import 'package:go_router/go_router.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال البريد وكلمة المرور")),
      );
      return;
    }

    setState(() => _isLoading = true);
    final result = await AuthService.signInWithEmail(email, password);
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم تسجيل الدخول بنجاح ✅")),
      );
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الدخول بالبريد")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "البريد الإلكتروني",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            PasswordField(controller: passwordController),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: Text(_isLoading ? "جاري تسجيل الدخول..." : "تسجيل الدخول"),
            ),
            TextButton(
              onPressed: () => context.push('/create'),
              child: const Text("إنشاء حساب جديد"),
            ),
            TextButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  await AuthService.resetPassword(email);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم إرسال رابط إعادة تعيين")),
                  );
                }
              },
              child: const Text("نسيت كلمة المرور؟"),
            ),
          ],
        ),
      ),
    );
  }
}
