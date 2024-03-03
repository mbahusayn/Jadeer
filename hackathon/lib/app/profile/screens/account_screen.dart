import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/loading_screen.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/profile/model/account.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController title = TextEditingController(),
      monthlyIncome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الحساب المصرفي",
        ),
        backgroundColor: ColorsApp.primaryColor,
      ),
      body: Column(children: [
        height16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextLabel(text: "الحسابات"),
              AddIconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      builder: (context) => AddAccountSheet(
                          title: title,
                          monthlyIncome: monthlyIncome)).then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
        const Divider(),
        FutureBuilder(
            future: SupabaseFunctions().getAllAccounts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Account> list = snapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return AccountWidget(
                      account: list[index],
                      icon: Icons.credit_card,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(indent: 16, endIndent: 16),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsApp.primaryColor,
                  ),
                );
              }
            }),
      ]),
    );
  }
}

class AddAccountSheet extends StatelessWidget {
  const AddAccountSheet({
    super.key,
    required this.title,
    required this.monthlyIncome,
  });

  final TextEditingController title;
  final TextEditingController monthlyIncome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              height32,
              const TextLabel(text: "العنوان"),
              TextFieldWidget(
                hint: "الحساب الأساسي",
                controller: title,
              ),
              const TextLabel(text: "الدخل الشهري"),
              TextFieldWidget(
                hint: "12000",
                controller: monthlyIncome,
                isNumber: true,
              ),
              height48,
              ElevatedButtonWidget(
                  onPressed: () async {
                    await SupabaseFunctions().addAccount({
                      "account_title": title.text,
                      "monthly_income": double.parse(monthlyIncome.text),
                      "balance": double.parse(monthlyIncome.text),
                      "total_budget": double.parse(monthlyIncome.text),
                      "user_id": currentUser.id,
                    });
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                  text: "إضافة"),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    super.key,
    required this.account,
    required this.icon,
  });
  final Account account;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16)),
          child: Icon(
            icon,
            color: ColorsApp.primaryColor,
          ),
        ),
        title: Text(account.accountTitle),
        trailing: Text("${account.balance} ريال"),
      ),
    );
  }
}
