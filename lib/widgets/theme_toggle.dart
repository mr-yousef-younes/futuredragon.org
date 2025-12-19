import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme.dart';

class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode),
          title: const Text("المظهر الليلي"),
          value: themeMode == ThemeMode.dark,
          onChanged: (val) {
            themeNotifier.setThemeMode(val ? ThemeMode.dark : ThemeMode.light);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton.icon(
            onPressed: () {
              themeNotifier.setThemeMode(ThemeMode.system);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم تفعيل المظهر التلقائي للنظام"),
                ),
              );
            },
            icon: const Icon(Icons.phone_android),
            label: const Text("🌓 المظهر التلقائي"),
          ),
        ),
      ],
    );
  }
}
