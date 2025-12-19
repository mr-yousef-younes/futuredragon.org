import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../ad/ad_help.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  static const String supportWhatsApp = "201288385795";

  final List<String> _supportReasons = [
    "احتاج؟",
    "احتاج للمساعدة",
    "مشكلة في حذف الحساب",
    "مشكلة مالية",
    "مشكله في وظيفة/ذر في التطبيق ",
    "مشاكله تتعلق بالفديوهات ",
    "مشاكل في بيع خدمات برمجية",
  ];

  String? _selectedReason = "احتاج؟";

  Future<void> _openWhatsAppChat() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? "guest";
    final email = user?.email ?? "no-email";

    if (_selectedReason == null || _selectedReason =="احتاج؟") {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("الرجاء اختيار سبب الدعم"),
          content: const Text("من فضلك اختر سبب المشكلة قبل التواصل مع الدعم."),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("حسناً"),
            ),
          ],
        ),
      );
      return;
    }

    final message = Uri.encodeComponent(
      "مرحباً، أحتاج المساعدة.\nسبب الدعم: $_selectedReason\nمعرف المستخدم: $uid\nالبريد: $email",
    );

    final url = Uri.parse("https://wa.me/$supportWhatsApp?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sendSupportEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? "guest";
    final email = user?.email ?? "no-email";

    if (_selectedReason == null || _selectedReason == "احتاج للمساعدة") {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("الرجاء اختيار سبب الدعم"),
          content: const Text("من فضلك اختر سبب المشكلة قبل إرسال البريد."),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("حسناً"),
            ),
          ],
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تأكيد الإرسال"),
        content: const Text(
          "هل أنت متأكد من إرسال رسالة الدعم؟ يرجى التأكد أن السبب حقيقي وأنك تتعامل بأدب.",
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed: () => context.pop(true),
            child: const Text("نعم"),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final uri = Uri(
      scheme: 'mailto',
      path: 'mr.yousef.younes@gmail.com',
      queryParameters: {
        'subject': 'طلب دعم من $_selectedReason',
        'body':
            'مرحباً، أحتاج المساعدة.\nسبب الدعم: $_selectedReason\nمعرف المستخدم: $uid\nالبريد: $email',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("المساعدة")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _selectedReason,
            decoration: const InputDecoration(
              labelText: "سبب الدعم",
              border: OutlineInputBorder(),
            ),
            items: _supportReasons
                .map(
                  (reason) =>
                      DropdownMenuItem(value: reason, child: Text(reason)),
                )
                .toList(),
            onChanged: (value) => setState(() => _selectedReason = value),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.chat, color: theme.primaryColor),
            title: Text(
              "التحدث مع الدعم الفني",
              style: theme.textTheme.bodyLarge,
            ),
            subtitle: Text(
              "سيفتح شات واتساب برسالة مجهزة",
              style: theme.textTheme.bodyMedium,
            ),
            onTap: _openWhatsAppChat,
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.email, color: theme.colorScheme.secondary),
            title: Text("بريد الدعم", style: theme.textTheme.bodyLarge),
            subtitle: const Text("support@futurehub.com"),
            onTap: _sendSupportEmail,
          ),
          const SizedBox(height: 32),
          bannerAdHelp(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
