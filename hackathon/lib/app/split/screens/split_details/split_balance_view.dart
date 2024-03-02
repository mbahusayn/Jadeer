import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/profile/model/user.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';

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
              TextTitle(
                text: "${split.totalBalance} ريال",
                color: Colors.white,
              )
            ],
          ),
        ),
        FutureBuilder(
            future: SupabaseFunctions().getSplitMembers(split.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> list = snapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return MemberExpenseWidget(
                      user: list[index],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
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
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
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
          const Row(
            children: [
              Text(
                " + 200",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Text(
                " ريال ",
                style: TextStyle(color: Colors.green),
              )
            ],
          )
        ],
      ),
    );
  }
}
