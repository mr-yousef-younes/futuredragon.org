import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint("❌ لا يمكن فتح الرابط: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent() {
      final theme = Theme.of(context);
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.campaign, color: Colors.green),
            title: Text("قناة واتساب", style: theme.textTheme.bodyLarge),
            onTap: () => _openLink(
                "https://whatsapp.com/channel/0029VbAvAfhKrWQwiNNBbV0c"),
          ),
          ListTile(
            leading: const Icon(Icons.group, color: Colors.teal),
            title: Text("واتساب (vip)",
                style: theme.textTheme.bodyLarge),
            onTap: () => _openLink(
                "https://chat.whatsapp.com/FZTV0t8sGJTC9kFNDjmlqz?mode=ems_copy_t"),
          ),
          ListTile(
            leading: const Icon(Icons.facebook, color: Colors.blue),
            title: Text("صفحة فيسبوك", style: theme.textTheme.bodyLarge),
            onTap: () => _openLink("https://www.facebook.com/yousefyounes2004"),
          ),
          ListTile(
            leading: const Icon(Icons.video_library, color: Colors.red),
            title: Text("قناة يوتيوب", style: theme.textTheme.bodyLarge),
            onTap: () => _openLink(
                "https://www.youtube.com/channel/UCI28ewF-6qe8NhkjHm9Mphg"),
          ),
          ListTile(
            leading: const Icon(Icons.music_note, color: Colors.purple),
            title: Text("حساب تيك توك", style: theme.textTheme.bodyLarge),
            onTap: () => _openLink("https://www.tiktok.com/@futurehub2004"),
          ),
          ListTile(
            leading: const Icon(Icons.send, color: Colors.blueAccent),
            title: Text("قناة تليجرام",
                style: theme.textTheme.bodyLarge),
            onTap: () => _openLink("https://t.me/futurehub2004"),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("المجتمع")),
      body: bodyContent(),
    );
  }
}
