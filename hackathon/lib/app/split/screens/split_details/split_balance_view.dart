import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/profile/model/user.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';

double totalBalance = 0;

class BalanceView extends StatelessWidget {
  const BalanceView({super.key, required this.split});
  final Split split;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: ColorsApp.primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextTitle(
                text: "الرصيد الإجمالي",
                color: Colors.white,
              ),
              FutureBuilder(
                  future: SupabaseFunctions().getSplit(split.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      totalBalance = snapshot.data!.totalBalance;
                    }
                    return TextTitle(
                      text: "${snapshot.data?.totalBalance ?? " "} ريال",
                      color: Colors.white,
                    );
                  })
            ],
          ),
        ),
        FutureBuilder(
            future: SupabaseFunctions().getSplitMembersExpenses(split.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<User, double> map = snapshot.data!;
                return Column(
                  children: [
                    for (var user in map.keys)
                      MemberExpenseWidget(
                        map: map,
                        user: user,
                      )
                  ],
                );
                //-----------
              } else {
                return const Center(
                  child:
                      CircularProgressIndicator(color: ColorsApp.primaryColor),
                );
              }
            }),
      ],
    );
  }
}

class MemberExpenseWidget extends StatelessWidget {
  const MemberExpenseWidget({
    super.key,
    required this.map,
    required this.user,
  });

  final Map map;
  final User user;

  @override
  Widget build(BuildContext context) {
    double splitAmount = calculate(totalBalance, map[user], map.length);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.grey, shape: BoxShape.circle),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              width8,
              Text(user.name),
            ],
          ),
          Row(
            children: [
              Text(
                " ${splitAmount.toStringAsFixed(1)}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: splitAmount > 0
                        ? ColorsApp.primaryColor
                        : Colors.red.shade300),
              ),
              Text(
                " ريال ",
                style: TextStyle(
                    color: splitAmount > 0
                        ? ColorsApp.primaryColor
                        : Colors.red.shade300),
              )
            ],
          )
        ],
      ),
    );
  }
}

double calculate(double totalBalance, double expensesAmount, int membersNo) {
  var splitForEach = totalBalance / membersNo;
  return expensesAmount - splitForEach;
}
