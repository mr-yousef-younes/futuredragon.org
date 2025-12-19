import 'package:flutter/material.dart';
import 'theme_toggle.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';
import '../ad/interstitial_ad.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'v${info.version}+${info.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.drawerTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Container(
          width: 250,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.whatshot,
                    size: 36,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'FutureHub',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'مرحباً',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: theme.dividerColor),
              // Items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 20),
                    ThemeToggle(),
                    const SizedBox(height: 15),
                    _drawerItem(
                      context,
                      Icons.home,
                      'الرئيسية',
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/home');
                      },
                    ),
                    _drawerItem(
                      context,
                      Icons.person,
                      'الملف الشخصي',
                      onTap: () => context.push('/profile'),
                    ),
                    _drawerItem(
                      context,
                      Icons.book,
                      'الدورات',
                      onTap: () {
                        final rootContext = GoRouter.of(
                          context,
                        ).routerDelegate.navigatorKey.currentContext;
                        Navigator.of(context).pop();
                        InterstitialAdService.showAd(context, () {
                          if (rootContext != null) {
                            GoRouter.of(rootContext).push('/courses');
                          }
                        });
                      },
                    ),
                    _drawerItem(
                      context,
                      Icons.help_outline,
                      'مساعدة',
                      onTap: () => context.push('/help'),
                    ),
                    _drawerItem(
                      context,
                      Icons.people,
                      'المجتمع',
                      onTap: () => context.push('/community'),
                    ),
                    _drawerItem(
                      context,
                      Icons.privacy_tip,
                      'سياسة الخصوصية',
                      onTap: () => context.push('/privacy'),
                    ),
                    const Divider(), // Divider between the items for better visual separation
                  ],
                ),
              ),
              // Footer
              Divider(color: theme.dividerColor),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    if (!kIsWeb)
                      Text(
                        _version,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 4),
                    Text(
                      '© 2018–${DateTime.now().year} FutureHub Dev Yousef-Younes',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.4,
                        ),
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context,
      IconData icon,
      String title, {
        VoidCallback? onTap,
      }) {
    final theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        color: isDark ? Colors.white : Colors.black87,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      horizontalTitleGap: 4,
      dense: true,
    );
  }
}
