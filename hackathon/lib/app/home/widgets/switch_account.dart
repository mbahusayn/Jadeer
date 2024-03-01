import 'package:flutter/material.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';
import 'package:u_credit_card/u_credit_card.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({
    super.key,
  });

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      width: getWidth(context),
      height: 600,
      child: ListView(physics: const NeverScrollableScrollPhysics(), children: [
        Container(
          decoration: const BoxDecoration(
              color: ColorsApp.primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: const Column(
            children: [
              height16,
              Center(
                child: Text(
                  "الحساب الحالي",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  child: CreditCardUi(
                    cardHolderFullName: 'Ahmad Abdulaziz',
                    cardNumber: '4786567812345678',
                    validThru: '10/24',
                    bottomRightColor: Color.fromARGB(8, 255, 255, 255),
                    topLeftColor: Color.fromARGB(119, 255, 255, 255),
                    cardProviderLogo: Text(
                      "15000 SR",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    cardType: CardType.other,
                    doesSupportNfc: false,
                    showValidFrom: false,
                  ),
                ),
              ),
              height8,
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: ColorsApp.secondaryColor,
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    width16,
                    const Text(
                      "الحساب الأساسي",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorsApp.secondaryColor),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    width16,
                    const Text(
                      "الحساب الثاني",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                height32,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      fixedSize: Size(getWidth(context), 45)),
                  child: const Text(
                    "حفظ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
