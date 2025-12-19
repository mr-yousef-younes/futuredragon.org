//create_account.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth_service.dart';
import '../widgets/password_field.dart';
import '../theme.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _gender;
  String? _country;
  String? _currency;
  DateTime? _birthDate;
  bool _isLoading = false;

  List<String> countries = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final list = await AuthService.loadCountries();
    if (!mounted) return;
    setState(() {
      countries = list;
    });
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: "اختر تاريخ الميلاد",
      confirmText: "تم",
      cancelText: "إلغاء",
      locale: const Locale('ar', 'EG'),
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final theme = Theme.of(context);
    final result = await AuthService.createAccount(
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      gender: _gender!,
      country: _country!,
      currency: _currency!,
      birthDate: _birthDate!.toIso8601String(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (result == "success") {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("تم إنشاء الحساب بنجاح!"),
          backgroundColor: ATheme.green,
        ),
      );
      context.go('/home');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: theme.colorScheme.error,
        ),
      );
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width < 500 ? width : 400,
                ),
                child: Column(
                  children: [
                    Text("أكمل ملفك الشخصي", style: theme.textTheme.titleLarge),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _firstName,
                            decoration: InputDecoration(
                              labelText: "الاسم الأول",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (v) =>
                                v!.trim().isEmpty ? "ادخل الاسم الأول" : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _lastName,
                            decoration: InputDecoration(
                              labelText: "الاسم الأخير",
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (v) =>
                                v!.trim().isEmpty ? "ادخل الاسم الأخير" : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "البريد الإلكتروني",
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return "ادخل البريد الإلكتروني";
                              }
                              final regex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              return regex.hasMatch(v.trim())
                                  ? null
                                  : "البريد الإلكتروني غير صالح";
                            },
                          ),
                          const SizedBox(height: 16),
                          PasswordField(
                            controller: _passwordController,
                            enabled: true,
                          ),
                          TextFormField(
                            readOnly: true,
                            onTap: _pickBirthDate,
                            decoration: InputDecoration(
                              labelText: "تاريخ الميلاد",
                              prefixIcon: const Icon(Icons.cake),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: TextEditingController(
                              text: _birthDate == null
                                  ? ''
                                  : "${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}",
                            ),
                            validator: (_) => _birthDate == null
                                ? "من فضلك اختر تاريخ الميلاد"
                                : null,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "النوع",
                              prefixIcon: const Icon(Icons.wc),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "ذكر",
                                child: Text("ذكر"),
                              ),
                              DropdownMenuItem(
                                value: "أنثى",
                                child: Text("أنثى"),
                              ),
                            ],
                            onChanged: (val) => _gender = val,
                            validator: (v) => v == null ? "اختر النوع" : null,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "الدولة",
                              prefixIcon: const Icon(Icons.flag),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: countries.map((country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(country),
                              );
                            }).toList(),
                            onChanged: (val) => _country = val,
                            validator: (val) =>
                                val == null ? "اختر الدولة" : null,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "عملة العرض",
                              prefixIcon: const Icon(Icons.monetization_on),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "USD",
                                child: Text("دولار أمريكي (USD)"),
                              ),
                              DropdownMenuItem(
                                value: "EGP",
                                child: Text("جنيه مصري (EGP)"),
                              ),
                              DropdownMenuItem(
                                value: "EUR",
                                child: Text("يورو (EUR)"),
                              ),
                              DropdownMenuItem(
                                value: "CNY",
                                child: Text("يوان صيني (CNY)"),
                              ),
                              DropdownMenuItem(
                                value: "SAR",
                                child: Text("ريال سعودي (SAR)"),
                              ),
                              DropdownMenuItem(
                                value: "CAD",
                                child: Text("دولار كندي (CAD)"),
                              ),
                            ],
                            onChanged: (val) => _currency = val,
                            validator: (v) => v == null ? "اختر العملة" : null,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withAlpha(
                                (0.1 * 255).round(),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 20,
                                  color: theme.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "الأسعار محددة باليورو (EUR)،ويتم تحديثها تلقائيًا حسب سعر الصرف لعملتك.",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor:
                                  theme
                                      .elevatedButtonTheme
                                      .style
                                      ?.backgroundColor
                                      ?.resolve({}) ??
                                  theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _isLoading ? null : _createAccount,
                            icon: const Icon(Icons.person_add, size: 28),
                            label: Text(
                              _isLoading
                                  ? "جاري إنشاء الحساب..."
                                  : "إنشاء حساب",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => context.push('/privacy'),
                            child: Text(
                              "سياسة الخصوصية",
                              style: theme.textButtonTheme.style?.textStyle
                                  ?.resolve({}),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withAlpha((0.5 * 255).round()),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
