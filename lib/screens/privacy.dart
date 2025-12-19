import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const String _contactEmail = 'example@gmail.com';
  static const String _lastUpdated = '1-10-2025';

  TextStyle get _heading =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle get _body => const TextStyle(fontSize: 15, height: 1.6);
  TextStyle get _muted =>
      const TextStyle(fontSize: 14, color: Colors.black54, height: 1.4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سياسة الخصوصية'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'سياسة الخصوصية — FutureHub',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'آخر تحديث: $_lastUpdated',
                    style: _muted,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 14),

                  Text('مقدمة', style: _heading, textAlign: TextAlign.right),
                  const SizedBox(height: 8),
                  Text(
                    'FutureHub هي منصة تعليمية وخدمية تابعة لشركة FutureDragon — تقدّم تطبيقات برمجية، دورات تعليمية، خدمات إصلاح برمجي، وخدمات مدفوعة أخرى بالإضافة إلى مجتمع دعم للعملاء. نحترم خصوصيتك وملتزمون بحماية بياناتك وتوفير بيئة آمنة ومهنية لكل مستخدمينا.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'البيانات التي نجمعها',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نجمع الحد الأدنى من البيانات الضرورية لتشغيل المنصة وتقديم الخدمات التجارية والتعليمية: ',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '• الاسم الكامل (للعرض في الملف الشخصي والوثائق).',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '• البريد الإلكتروني (للمصادقة، الفواتير، استرداد الحساب، والإشعارات).',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '• معلومات الدفع غير المُخزنة مباشرة (يتم تمريرها إلى مزوّد الدفع الآمن؛ راجع قسم "المدفوعات").',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '• بيانات الاستخدام التقنية والوظيفية لتشغيل الخدمة وتحسين المنتج (مثل سجلات الأخطاء، إعدادات المستخدم، وتحليلات الأداء).',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  Text(
                    'لماذا نجمع هذه البيانات',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نستخدم بياناتك للأغراض التالية فقط — ولتحقيق تجربة خدمة احترافية وآمنة:',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '• المصادقة وتسجيل الدخول وإدارة الحساب.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '• تمكين وقيادة عمليات الشراء، الفوترة، وإصدار الإيصالات.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '• تقديم المحتوى التعليمي، منح الوصول للدورات، وتسليم المنتجات البرمجية.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '• الدعم الفني وخدمة العملاء بما في ذلك إصلاح الأخطاء ومتابعة الطلبات.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '• تحسين الخدمة والتحليلات وتحسين جودة المحتوى والمنتجات.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // المدفوعات والفوترة والاسترداد
                  Text(
                    'المدفوعات والفوترة وسياسة الاسترداد',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لعمليات الشراء نستخدم مزوّدَي دفع طرف ثالث آمنين ومرخّصين. لا نقوم بتخزين بيانات بطاقة الدفع على خوادمنا؛ تُدار جميع المعاملات عبر مزوّدي الدفع المعتمدين. يتم إصدار الفواتير وإرسال الإيصالات عبر البريد الإلكتروني المسجّل.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'سياسة الاسترداد:',
                    style: _body.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• إذا أكمل المستخدم أكثر من حصتين في أي كورس، يمكنه استرداد المبلغ بعد خصم قيمة حصتين من إجمالي المبلغ المدفوع.\n'
                        '• إذا أكمل المستخدم حصتين أو أقل، يسترد المبلغ كاملًا.\n'
                        '• في كورسات الأطفال، يتم خصم 20٪ من إجمالي المبلغ عند الاسترداد.\n'
                        '• لطلبات دعم مالي لتخفيض الكورسات، يجب التواصل مع $_contactEmail مباشرة لتقديم الطلب ومراجعته من قبل فريق الدعم.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  // أساس المعالجة والامتثال
                  Text(
                    'أساس المعالجة والامتثال للقوانين',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تعتمد معالجة بياناتك على أساسات قانونية واضحة: تنفيذ العقد (تقديم خدمات ودورات وبيع منتجات)، والامتثال للالتزامات القانونية، أو موافقتك عند الحاجة (مثل التسويق). نعمل على الامتثال لأطر حماية البيانات الدولية كلما أمكن (مثل GDPR حيث ينطبق) ونقوم بالاستجابة لطلبات الحقوق وفق القوانين المعمول بها.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // مدة الاحتفاظ
                  Text(
                    'مدة الاحتفاظ بالبيانات',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نحتفظ ببيانات الحساب طالما استمر الحساب أو كانت هناك حاجة قانونية أو تشغيلية. بعد طلب الحذف نقوم بإلغاء تنشيط الحساب مباشرة ونحتفظ بنسخ احتياطية مؤقتة لمدة 90 يومًا لأغراض الاسترداد والحماية من الاحتيال. قد نخزن سجلات مالية أو سجلات امتثال لفترات أطول (حتى 7 سنوات) بحسب المتطلبات القانونية المحلية والدولية.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // نقل البيانات الدولي
                  Text(
                    'نقل وتخزين البيانات دولياً',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'يتم تخزين ومعالجة بياناتك في خدمات سحابية (مثل Firebase وأدوات مزودي الخدمات) والتي قد تعمل عبر مراكز بيانات متعددة حول العالم. نطبق ضوابط مناسبة عند نقل البيانات بين الدول (تشفير، عقود، شروط تشغيل). إذا كان لديك استفسار حول مكان تخزين بياناتك، راسلنا عبر $_contactEmail.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // مشاركة أطراف ثالثة
                  Text(
                    'مشاركة بياناتك مع أطراف ثالثة',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نشارك بياناتك فقط مع مزودي خدمات موثوقين والضروريين لتشغيل الخدمة: مزوّدو الدفع، موفّرو الاستضافة، أدوات التحليلات الأساسية، مزوّدو البريد الإلكتروني للدعم، ومقدمو خدمات إشعارات الدفع. كل مشاركة تتم بموجب اتفاقيات تضمن السرية والأمن. نحن لا نبيع بياناتك لأطراف ثالثة لأغراض الربح التجاري.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // الكوكيز والتحليلات
                  Text(
                    'الكوكيز والتحليلات',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نستخدم تقنيات قياس وتحليلات بسيطة لتحسين المنتج (كوكيز خفيفة أو معرفات جهاز). يمكن التحكم في بعض خيارات التحليلات من إعدادات التطبيق أو عبر سحب الموافقة. هذه البيانات تُستخدم لجعل التجربة أفضل وليست مرتبطة بالإعلانات المخصصة دون موافقتك.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // الأمان
                  Text(
                    'أمان البيانات',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نطبّق تدابير تقنية وإجرائية لحماية بياناتك: تشفير حركة البيانات (TLS)، تخزين آمن، وحدود وصول داخلية، ومراجعات أمنية دورية. مع ذلك، لا توجد وسيلة رقمية 100% آمنة؛ في حال حدوث خرق سنبلغ المتأثرين والسلطات المختصة حسب اللوائح المطبقة وسنشرح التدابير التصحيحية التي اتخذناها.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // حقوق المستخدمين
                  Text(
                    'حقوقك وطرق ممارستها',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لديك حقوق واضحة على بياناتك: الوصول، التصحيح، الحذف، تقييد المعالجة، وطلب نقل البيانات. لممارسة هذه الحقوق، راسلنا على $_contactEmail مع بياناتك وإيضاح الطلب. نهدف للرد خلال 30 يومًا عادةً، وقد نطلب تحققًا إضافيًا لحماية حسابك.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // آليات الشكاوى والجهات الرقابية
                  Text(
                    'الشكوى والجهات الرقابية',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'إذا لم تكن راضيًا عن استجابتنا لطلب خصوصيتك، يمكنك تقديم شكوى للسلطة الرقابية المحلية المعنية بحماية البيانات في بلدك. سنزوّدك بمعلومات جهة الاتصال عند طلبها ونعاون في التحقيقات الرسمية عند الحاجة.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // الأطفال
                  Text(
                    'خصوصية الأطفال',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لا نجمع معلومات شخصية عن الأطفال دون موافقة ولي الأمر. إذا كنت ولي أمر وتعتقد أن بيانات طفلك قد جُمعت دون موافقة، راسلنا فورًا على $_contactEmail وسنتخذ الإجراءات المناسبة بسرعة.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // روابط وأدوات الطرف الثالث
                  Text(
                    'روابط ومحتوى طرف ثالث',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'قد يحتوي التطبيق على روابط أو محتوى تابعًا لأطراف ثالثة؛ سياسات الخصوصية لتلك الخدمات قد تختلف. نحن غير مسؤولين عن ممارساتهم، وننصح بمراجعة سياساتهم قبل تقديم أي بيانات شخصية.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // الحفظ والتعديلات
                  Text(
                    'التغييرات في السياسة',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'قد نحدّث هذه السياسة دوريًا لتعكس التغيرات في الخدمة أو المتطلبات القانونية. عند تغييرات جوهرية سنعرض إشعارًا داخل التطبيق ونحدّث تاريخ "آخر تحديث" في أعلى الصفحة.',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),

                  // التواصل
                  Text(
                    'التواصل معنا',
                    style: _heading,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'للاستفسارات وطلب الحقوق أو أي مساعدة تتعلق بالخصوصية، تواصل مع فريق الخصوصية على: $_contactEmail',
                    style: _body,
                    textAlign: TextAlign.right,
                  ),
                  // فصل بين العربي والانجليزي
                  const SizedBox(height: 24),
                  Text(
                    'من خلال استخدام FutureHub، فإنك تقر بأنك قد قرأت وفهمت سياسة الخصوصية هذه.',
                    style: _muted,
                  )
                ],
              ),
            ),

            const Divider(height: 2),

            const SizedBox(height: 18),

            // ====== English Section (LTR) ======
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Privacy Policy — FutureHub', style: _heading),
                const SizedBox(height: 12),
                Text('Last updated: $_lastUpdated', style: _muted),
                const SizedBox(height: 14),

                Text('Introduction', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'FutureHub is an educational and service platform operated by FutureDragon. We offer software products, learning courses, custom development services, and a customer community. We respect your privacy and are committed to protecting your personal information while providing a secure and professional service.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Data we collect', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We collect the minimum personal data necessary to operate the platform and deliver commercial and educational services:',
                  style: _body,
                ),
                const SizedBox(height: 6),
                Text(
                  '• Full name (for profile display and documentation).',
                  style: _body,
                ),
                Text(
                  '• Email address (for authentication, billing, receipts, and essential notifications).',
                  style: _body,
                ),
                Text(
                  '• Payment-related data handled via PCI-compliant payment processors (we do not store card details on our servers).',
                  style: _body,
                ),
                Text(
                  '• Technical and usage data for service operation and improvement (error logs, settings, analytics).',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Purpose of processing', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We use your information only for the following purposes, to ensure a reliable and secure customer experience:',
                  style: _body,
                ),
                const SizedBox(height: 6),
                Text(
                  '• User authentication and account management.',
                  style: _body,
                ),
                Text(
                  '• Enabling purchases, billing, and issuing receipts.',
                  style: _body,
                ),
                Text(
                  '• Delivering access to courses and software products.',
                  style: _body,
                ),
                Text(
                  '• Technical support, product maintenance, and customer service.',
                  style: _body,
                ),
                Text(
                  '• Product improvement and performance analytics.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                // ====== Payments, Billing & Refunds (English) ======
                Text(
                  'Payments, Billing & Refunds',
                  style: _heading,
                ),
                const SizedBox(height: 8),
                Text(
                  'For purchases, we use secure and licensed third-party payment providers. We do not store credit card information on our servers; all transactions are handled by certified and authorized payment processors. Billing records and receipts are emailed to your registered address.',
                  style: _body,
                ),
                const SizedBox(height: 6),
                Text(
                  'Refund Policy:',
                  style: _body.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '• If a user completes more than two sessions in any course, they can request a refund after deducting the cost of two sessions from the total amount paid.\n'
                      '• If a user completes two sessions or fewer, the full amount is refunded.\n'
                      '• For children’s courses, 20% of the total amount is deducted in case of a refund.\n'
                      '• For requests for financial support to reduce course fees, users should contact $_contactEmail directly to submit the request for review by the support team.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Data minimization & user control', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We adhere to data minimization principles and provide you control over your data: edit profile, export personal data, or request deletion. We do not sell personal data and will use data for marketing only with explicit consent, which you can withdraw at any time.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Legal basis & compliance', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'Processing is based on clear legal grounds: contract performance (providing accounts/services), legal obligations, and consent where applicable. We strive to comply with international data protection frameworks (e.g., GDPR where applicable) and respond to data subject requests under applicable laws.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Data retention', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We retain account data while your account is active. Upon deletion request we deactivate the account and keep backup copies for 90 days for recovery and fraud prevention. Financial and compliance records may be kept longer (up to 7 years) to satisfy legal obligations.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('International transfers', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'Your data may be stored and processed in cloud services (e.g., Firebase) across multiple regions. We implement appropriate safeguards when transferring data across borders (encryption, contractual controls). Contact us if you need details about where your data is stored.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Third-party services', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We share data only with trusted third-party providers necessary to run the app (payment processors, hosting, analytics, email delivery, push notifications) under confidentiality agreements. We DO NOT sell your personal data.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Cookies & analytics', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We use lightweight cookies and analytics to improve product quality and user experience. Some analytics can be disabled in app settings or via consent mechanisms. These signals are not used for targeted advertising without explicit consent.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Security measures', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We apply administrative and technical safeguards including TLS in transit and secure storage. Access to personal data is limited and periodically reviewed. No system is 100% secure; in case of a breach we will notify affected users and authorities as required by law and take corrective actions.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Your rights', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'You have rights to access, correct, delete, restrict processing, and request a portable copy of your personal data. To exercise these rights contact us at $_contactEmail with your request and proof of identity. We aim to respond within 30 days and may request additional verification to protect your account.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Complaints & supervisory authorities', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'If you are not satisfied with our response you may lodge a complaint with your local data protection supervisory authority. We will provide assistance and information upon request.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Children', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We do not knowingly collect personal data from children without parental consent. If you are a parent and believe your child’s data was collected without consent, contact us at $_contactEmail and we will investigate and take appropriate action promptly.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Third-party links', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'The app may include links to third-party sites with different privacy practices. We are not responsible for their policies; please review their notices before sharing personal data.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Policy changes', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'We may update this policy from time to time. Material changes will be announced in-app and the "last updated" date will be revised accordingly.',
                  style: _body,
                ),
                const SizedBox(height: 12),

                Text('Contact', style: _heading),
                const SizedBox(height: 8),
                Text(
                  'For privacy inquiries, to exercise your rights, or for complaints, contact: $_contactEmail',
                  style: _body,
                ),
                const SizedBox(height: 20),
                Text(
                  'By using FutureHub, you acknowledge that you have read and understood this Privacy Policy.',
                  style: _muted,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
