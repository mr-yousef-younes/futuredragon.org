import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../ad/ad_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("الملف الشخصي")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).primaryColor,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child: user?.photoURL == null
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "الاسم الكامل:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              user?.displayName ?? "غير محدد",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            Text(
              "البريد الإلكتروني:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? "غير متوفر",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 32),
            const Spacer(),
            bannerAdProfile(context),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/settings');
                },
                icon: const Icon(Icons.settings),
                label: const Text("إعدادات الحساب"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
