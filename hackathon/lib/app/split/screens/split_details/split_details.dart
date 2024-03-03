import 'package:flutter/material.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/screens/members_screen.dart';
import 'package:hackathon/app/split/screens/split_details/split_balance_view.dart';
import 'package:hackathon/app/split/screens/split_details/split_expense_view.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

final _tabs = [
  const Tab(text: "النفقات"),
  const Tab(text: "الرصيد"),
];

class SplitDetails extends StatelessWidget {
  const SplitDetails({super.key, required this.split});

  final Split split;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(split.title),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MembersScreen(
                              split: split,
                            )));
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: ColorsApp.primaryColor, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.people,
                    color: Colors.white,
                  )),
            ),
          ],
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    width: getWidth(context),
                    clipBehavior: Clip.hardEdge,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16)),
                    child: Image.asset(
                      "assets/images/account.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: ColorsApp.secondaryColor,
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        )),
                  )
                ],
              ),
              Container(
                height: 40,
                width: getWidth(context),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TabBar(
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ColorsApp.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 2,
                            spreadRadius: 0.5)
                      ]),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: _tabs,
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  SplitExpenseView(split: split),
                  BalanceView(split: split)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
