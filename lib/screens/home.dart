import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_drawer.dart';
import '../auth_service.dart';
import '../theme.dart';
import '../ad/banner_ad.dart';
import '../ad/interstitial_ad.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>

    with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    InterstitialAdService.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth > 900;
        final double bodyWidth = isLargeScreen
            ? constraints.maxWidth - 260
            : constraints.maxWidth;

        if (isLargeScreen && !isDrawerOpen) {
          isDrawerOpen = true;
        }

        return Scaffold(
          onDrawerChanged: (opened) {
            setState(() {
              isDrawerOpen = opened;
            });
          },
          appBar: AppBar(
            title: !isDrawerOpen
                ? Row(
                    children: const [
                      Icon(Icons.whatshot, size: 28, color: Colors.white),
                      SizedBox(width: 8),
                      Text('FutureHub', style: TextStyle(fontSize: 22)),
                    ],
                  )
                : null,
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              TextButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('تأكيد الخروج'),
                        content: const Text('هل تريد تسجيل الخروج بالفعل؟'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('لا'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('نعم'),
                          ),
                        ],
                      );
                    },
                  );
                  if (confirm == true) {
                    await AuthService.signOut();
                    if (!context.mounted) return;
                    GoRouter.of(context).replace('/');
                  }
                },
                child: const Text(
                  'خروج',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          drawer: !isLargeScreen ? const Drawer(child: AppDrawer()) : null,
          body: isLargeScreen
              ? Row(
                  children: [
                    const SizedBox(width: 260, child: AppDrawer()),
                    Expanded(
                      child: _buildBody(context, bodyWidth, isLargeScreen),
                    ),
                  ],
                )
              : _buildBody(context, bodyWidth, isLargeScreen),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    double bodyWidth,
    bool isLargeScreen,
  ) {
    final double padding = 20;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 18),
            child: _buildHero(context, isLargeScreen),
          ),
          const SizedBox(height: 10),
          bannerAdCard(context),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: _buildSubscriptionCard(context),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context, bool isLargeScreen) {
    Theme.of(context);

    const headline = 'من الرماد إلى القمة';
    const sub = 'ابدأ رحلتك كطائر فينيق\nتعلم، تطور، واصنع مستقبلك التقني مع FutureHub.';
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isLargeScreen ? 380 : 320),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ATheme.phoenixStart.withAlpha((0.18 * 255).round()),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    headline,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    sub,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context.push('/start');
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('ابدأ الآن'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ATheme.phoenixStart,
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          InterstitialAdService.showAd(
                            context,
                                () { context.push('/courses'); },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white24),
                        ),
                        child: const Text('تصفح الدورات'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildSubscriptionCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اشتراك بريميوم',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: ATheme.phoenixStart,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'وصول كامل لكل الدورات، شهادات معتمدة، وميزات حصرية.',
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ATheme.phoenixStart,
                        ),
                        child: const Text('اشترك الآن'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('اطلب تجربة مجانية'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: ATheme.phoenixStart.withAlpha((0.18 * 255).round()),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.workspace_premium,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ATheme.phoenixStart, ATheme.phoenixEnd],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ATheme.phoenixStart.withAlpha((0.14 * 255).round()),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),
    );
  }
