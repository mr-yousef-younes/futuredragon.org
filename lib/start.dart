// start.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment_page.dart';

// نفترض إنك ضايف الثيم الجديد هنا

class Start extends StatelessWidget {
  const Start({super.key});

  // Helper to format money and convert USD->EGP
  static const double egpPerUsd = 50.0;
  String usdToEgpString(double usd) {
    final egp = usd * egpPerUsd;
    final f = NumberFormat('#,###', 'en_US');
    return '${f.format(egp)} ج.م';
  }

  Widget _buildPackageCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required double priceUsd,
    required VoidCallback onBuy,
    required bool isFeatured,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: isFeatured ? 6 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: theme.cardColor, // استخدم لون البطاقة من الثيم
      child: InkWell(
        onTap: onBuy,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.colorScheme.primary.withAlpha(
                    (0.12 * 255).round(),
                  ),
                ),
                child: Icon(
                  Icons.play_circle_fill,
                  size: 42,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.titleMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '\$${priceUsd.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          usdToEgpString(priceUsd),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBuySheet(
    BuildContext context, {
    required String title,
    required double priceUsd,
    required VoidCallback onVodafone,
    required VoidCallback onFawry,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                title: Text(title, style: theme.textTheme.titleMedium),
                subtitle: Text(
                  'السعر: \$${priceUsd.toStringAsFixed(2)} • ${usdToEgpString(priceUsd)}',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'اختر طريقة الدفع',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(
                  Icons.phone_iphone,
                  color: theme.colorScheme.primary,
                ),
                title: const Text('Vodafone Cash'),
                onTap: () {
                  Navigator.pop(ctx);
                  onVodafone();
                },
              ),
              ListTile(
                leading: Icon(Icons.payment, color: theme.colorScheme.primary),
                title: const Text('Fawry'),
                onTap: () {
                  Navigator.pop(ctx);
                  onFawry();
                },
              ),
              const SizedBox(height: 10),
              Text(
                'ملاحظة: مقدمة AI مجانية مع أي عملية شراء أكثر من \$5.',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _startVodafonePayment(
    BuildContext ctx,
    String productId,
    double priceUsd,
  ) {
  Navigator.push(
    ctx,
    MaterialPageRoute(
      builder: (_) => PaymentServicePage(
        title: productId, 
        priceUsd: priceUsd,
      ),
    ),
  );
}

  void _startFawryPayment(BuildContext ctx, String productId, double priceUsd) 
  {
  Navigator.push(
    ctx,
    MaterialPageRoute(
      builder: (_) => PaymentServicePage(
        title: productId,
        priceUsd: priceUsd,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final double packagePriceUsd = 4.28;
    final double fullOfferUsd = 5.99;
    final double dartCourse = 14.0;
    final double fullStack = 20.0;
    final double pythonBasics = 10.0;
    final double pythonAI = 16.0;

    return Scaffold(
      appBar: AppBar(title: const Text('ابدأ الآن')),
      body: ListView(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.primary.withAlpha((0.06 * 255).round()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اختر الحزمة أو الدورة المناسبة لك',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 6),
                Text(
                  'حزم تمهيدية ودورات متقدمة — اختر العروض التي تناسبك',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // الملحوظة المحسّنة قبل حزم الأطفال
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ملحوظة مهمة قبل حزم الأطفال :',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: theme.colorScheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'حصتين بث مباشر: حصّة قبل بداية الكورس وحصّة بعد نهايته.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: theme.colorScheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'شهادة اجتياز الكورس.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: theme.colorScheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'مشروع عملي.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'في حال شراء العرض الكامل: تضاف حصّة شرح مشروع تخرج كامل.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.card_giftcard,
                          color: Colors.purple,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'هدية مجانية مع حزم الأطفال: حزمة شرح مقدمة في الذكاء الاصطناعي (AI) وهندسة البرمبت.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('حزم الأطفال', style: theme.textTheme.titleMedium),
          ),

          _buildPackageCard(
            context,
            title: 'حزمة تأهيل للبرمجة (مرفقة)',
            subtitle:
            'احصل على 6 فيديوهات تعليمية هدية مجانًا مع أي حزمة! دروس ممتعة للأطفال لتعليم أساسيات الإنترنت وأنظمة التشغيل.',
            priceUsd: 0.0,
            isFeatured: false,
            onBuy: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'الحزمة مرفقة تلقائيًا مع عمليات الشراء',
                    style: theme.textTheme.bodyMedium,
                  ),
                  backgroundColor: theme.snackBarTheme.backgroundColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),

          _buildPackageCard(
            context,
            title: 'حزمة أساسيات علوم الحاسب للأطفال',
            subtitle: '12 فيديو + 6 فيديو تحضيري (مرفق)',
            priceUsd: packagePriceUsd,
            isFeatured: true,
            onBuy: () {
              _showBuySheet(
                context,
                title: 'حزمة أساسيات علوم الحاسب للأطفال',
                priceUsd: packagePriceUsd,
                onVodafone: () =>
                    _startVodafonePayment(context, 'pkg_children_cs', packagePriceUsd),
                onFawry: () =>
                    _startFawryPayment(context, 'pkg_children_cs', packagePriceUsd),
              );
            },
          ),

          _buildPackageCard(
            context,
            title: 'حزمة أساسيات البرمجة بـ Python + الجبر',
            subtitle: '12 فيديو + 6 فيديو تحضيري (مرفق)',
            priceUsd: packagePriceUsd,
            isFeatured: true,
            onBuy: () {
              _showBuySheet(
                context,
                title: 'حزمة أساسيات البرمجة بـ Python',
                priceUsd: packagePriceUsd,
                onVodafone: () =>
                    _startVodafonePayment(context, 'pkg_python_basics', packagePriceUsd),
                onFawry: () =>
                    _startFawryPayment(context, 'pkg_python_basics', packagePriceUsd),
              );
            },
          ),

          // Full offer banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: theme.cardColor,
              child: ListTile(
                title: Text(
                  'العرض الكامل',
                  style: theme.textTheme.titleMedium,
                ),
                subtitle: Text(
                  'احصل على كل حزم الأطفال 4 حزم لسنة كاملة — \$${fullOfferUsd.toStringAsFixed(2)} • ${usdToEgpString(fullOfferUsd)}',
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    _showBuySheet(
                      context,
                      title: 'العرض الكامل (سنة)',
                      priceUsd: fullOfferUsd,
                      onVodafone: () =>
                          _startVodafonePayment(context, 'offer_full_year', fullOfferUsd),
                      onFawry: () =>
                          _startFawryPayment(context, 'offer_full_year', fullOfferUsd),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  child: const Text('اشتري العرض'),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Advanced courses banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withAlpha((0.1 * 255).round()),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'الدورات المتقدمة بث مباشر 💻✨\nمع مشاريع عملية 🛠️، معرض أعمال 📁، تجهيز CV 📝، واستعداد للمقابلات 🎯!',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                'Dart & Flutter — Full Course',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'أهداف: إتقان لغة Dart، تطوير تطبيقات Flutter على جميع المنصات، وربطها بخدمات Firebase ونشرها.',
                maxLines: 3,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${dartCourse.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    usdToEgpString(dartCourse),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                _showBuySheet(
                  context,
                  title: 'Dart & Flutter — Full Course',
                  priceUsd: dartCourse,
                  onVodafone: () => _startVodafonePayment(
                    context,
                    'course_dart_flutter',
                    dartCourse,
                  ),
                  onFawry: () => _startFawryPayment(
                    context,
                    'course_dart_flutter',
                    dartCourse,
                  ),
                );
              },
            ),
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                'Full‑Stack Development',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'أهداف: تطوير موقع كامل يشمل الواجهة الأمامية والخلفية (Frontend + Backend)، إدارة قواعد البيانات، الاستضافة، وتطبيق أساسيات الأمان وأختبار الثغرات.',
                maxLines: 4,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${fullStack.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    usdToEgpString(fullStack),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                _showBuySheet(
                  context,
                  title: 'Full‑Stack Development',
                  priceUsd: fullStack,
                  onVodafone: () => _startVodafonePayment(
                    context,
                    'course_fullstack',
                    fullStack,
                  ),
                  onFawry: () => _startFawryPayment(
                    context,
                    'course_fullstack',
                    fullStack,
                  ),
                );
              },
            ),
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                'Python Basics (Flask)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'أهداف: تعلم أساسيات Python وFlask، إنشاء واجهات برمجة التطبيقات (APIs)، وإدارة قواعد بيانات بسيطة.',
                maxLines: 3,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${pythonBasics.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    usdToEgpString(pythonBasics),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                _showBuySheet(
                  context,
                  title: 'Python Basics (Flask)',
                  priceUsd: pythonBasics,
                  onVodafone: () => _startVodafonePayment(
                    context,
                    'course_python_basic',
                    pythonBasics,
                  ),
                  onFawry: () => _startFawryPayment(
                    context,
                    'course_python_basic',
                    pythonBasics,
                  ),
                );
              },
            ),
          ),

          // Dart & Flutter Course
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: theme.cardColor,
            child: ListTile(
              title: Text(
                'Dart & Flutter — Full Course',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'أهداف: إتقان لغة Dart، تطوير تطبيقات Flutter على جميع المنصات، وربطها بخدمات Firebase ونشرها.',
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${dartCourse.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    usdToEgpString(dartCourse),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                _showBuySheet(
                  context,
                  title: 'Dart & Flutter — Full Course',
                  priceUsd: dartCourse,
                  onVodafone: () =>
                      _startVodafonePayment(context, 'course_dart_flutter', dartCourse),
                  onFawry: () =>
                      _startFawryPayment(context, 'course_dart_flutter', dartCourse),
                );
              },
            ),
          ),

          // Full-Stack Development
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: theme.cardColor,
            child: ListTile(
              title: Text(
                'Full‑Stack Development',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'أهداف: تطوير موقع كامل يشمل الواجهة الأمامية والخلفية (Frontend + Backend)، إدارة قواعد البيانات، الاستضافة، وتطبيق أساسيات الأمان وأختبار الثغرات.',
                style: theme.textTheme.bodyMedium,
                maxLines: 4,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${fullStack.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    usdToEgpString(fullStack),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                _showBuySheet(
                  context,
                  title: 'Full‑Stack Development',
                  priceUsd: fullStack,
                  onVodafone: () =>
                      _startVodafonePayment(context, 'course_fullstack', fullStack),
                  onFawry: () =>
                      _startFawryPayment(context, 'course_fullstack', fullStack),
                );
              },
            ),
          ),

          // Python Basics (Flask)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: theme.cardColor,
            child: ListTile(
              title: Text(
                'Python Basics (Flask)',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'أهداف: تعلم أساسيات Python وFlask، إنشاء واجهات برمجة التطبيقات (APIs)، وإدارة قواعد بيانات بسيطة.',
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${pythonBasics.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    usdToEgpString(pythonBasics),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                _showBuySheet(
                  context,
                  title: 'Python Basics (Flask)',
                  priceUsd: pythonBasics,
                  onVodafone: () =>
                      _startVodafonePayment(context, 'course_python_basic', pythonBasics),
                  onFawry: () =>
                      _startFawryPayment(context, 'course_python_basic', pythonBasics),
                );
              },
            ),
          ),

          // Python + AI
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: theme.cardColor,
            child: ListTile(
              title: Text(
                'Python + AI',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'أهداف: مقدمة في تعلم الآلة (ML)، معالجة البيانات، تدريب نموذج بسيط، وتنفيذ تطبيق عملي صغير.',
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${pythonAI.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    usdToEgpString(pythonAI),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                _showBuySheet(
                  context,
                  title: 'Python + AI',
                  priceUsd: pythonAI,
                  onVodafone: () =>
                      _startVodafonePayment(context, 'course_python_ai', pythonAI),
                  onFawry: () =>
                      _startFawryPayment(context, 'course_python_ai', pythonAI),
                );
              },
            ),
          ),

          // Python bundle promo
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Text(
                      'عرض بايثون (دورتين) - خصم 23%',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Python Basics + Python + AI بسعر 20\$ بدلاً من 26\$ — وفر 6\$!\nتعلّم Python وAI وابدأ مسيرتك كمطور ذكاء اصطناعي / Data Scientist مبتدئ.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        final total = pythonBasics + pythonAI; // $26
                        final pay = total * 0.769; // تطبيق الخصم
                        _showBuySheet(
                          context,
                          title: 'Bundle: Python Basics + Python+AI (خصم 23.5%)',
                          priceUsd: pay,
                          onVodafone: () => _startVodafonePayment(context, 'bundle_python', pay),
                          onFawry: () => _startFawryPayment(context, 'bundle_python', pay),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: const Text('اشترِ العرض'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

        ],
      ),
    );
  }
}
