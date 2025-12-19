// payment_service_page.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
class PaymentServicePage extends StatefulWidget {
  final String title;
  final double priceUsd;

  const PaymentServicePage({
    super.key,
    required this.title,
    required this.priceUsd,
  });

  static const double egpPerUsd = 50.0;

  @override
  State<PaymentServicePage> createState() => _PaymentServicePageState();
}

class _PaymentServicePageState extends State<PaymentServicePage> {
  bool _agreedToPolicy = false;

  String usdToEgpString(double usd) {
    final egp = usd * PaymentServicePage.egpPerUsd;
    final f = NumberFormat('#,###', 'en_US');
    return '${f.format(egp)} ج.م';
  }

  void _startVodafonePayment(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Vodafone Cash'),
          content: SizedBox(
            width: 350,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'يرجى تحويل المبلغ ${usdToEgpString(widget.priceUsd)} إلى رقم محفظتي:',
                  ),
                  const SizedBox(height: 10),
                  QrImageView(
                    data: '01004788956',
                    size: 180,
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    'رقم المحفظة: 01004788956',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'بعد الدفع، أرسل إيصال الدفع عبر التطبيق أو واتساب لتأكيد العملية.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('تم'),
            ),
          ],
        );
      },
    );
  }
  void _startFawryPayment(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Fawry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'يمكنك الدفع عبر Fawry مقابل ${usdToEgpString(widget.priceUsd)}.',
              ),
              const SizedBox(height: 8),
              Text(
                '⚠️ ملاحظة: الدفع عبر فوري تحت التطوير حالياً!',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'بعد الدفع، أرسل إيصال الدفع لتأكيد العملية.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('تم'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('الدفع: ${widget.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: theme.cardColor,
              child: ListTile(
                title: Text(widget.title, style: theme.textTheme.titleMedium),
                subtitle: Text(
                  '\$${widget.priceUsd.toStringAsFixed(2)} • ${usdToEgpString(widget.priceUsd)}',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreedToPolicy,
                  onChanged: (val) {
                    setState(() {
                      _agreedToPolicy = val ?? false;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(
                          text:
                          'لقد قرأت قسم الدفع في سياسة الاستخدام وأوافق على الشروط قبل الدفع. ',
                        ),
                        TextSpan(
                          text: 'عرض سياسة الخصوصية والاستخدام',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                             context.push('/privacy');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'اختر طريقة الدفع:',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.phone_iphone),
              label: const Text('Vodafone Cash'),
              onPressed: _agreedToPolicy
                  ? () => _startVodafonePayment(context)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.payment),
              label: const Text('Fawry'),
              onPressed:
              _agreedToPolicy ? () => _startFawryPayment(context) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
