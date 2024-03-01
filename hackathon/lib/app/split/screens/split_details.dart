import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/home/widgets/date_picker.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/model/split_expense.dart';
import 'package:hackathon/app/split/screens/members_screen.dart';
import 'package:hackathon/app/split/screens/split_screen.dart';
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                width: getWidth(context),
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
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
              const Expanded(
                  child: TabBarView(
                children: [SplitExpenseView(), BalanceView()],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SplitExpenseView extends StatelessWidget {
  const SplitExpenseView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height16,
        Align(
            alignment: Alignment.centerLeft,
            child: AddIconButton(onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: SizedBox(
                          height: 480,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "إضافة إنفاق جديد",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                height32,
                                const TextLabel(text: "العنوان"),
                                TextFieldWidget(
                                    hint: "",
                                    controller: TextEditingController()),
                                const TextLabel(text: "المبلغ"),
                                TextFieldWidget(
                                  hint: "",
                                  controller: TextEditingController(),
                                  isNumber: true,
                                ),
                                const TextLabel(text: "التاريخ"),
                                height8,
                                const DatePickerWidget(),
                                height48,
                                ElevatedButtonWidget(
                                    onPressed: () {}, text: "إضافة")
                              ],
                            ),
                          ),
                        ),
                      ));
            })),
        const Divider(),
        SplitExpenseWidget(expense: splitExpense1),
        const Divider(),
        SplitExpenseWidget(expense: splitExpense2),
        const Divider()
      ],
    );
  }
}

class SplitExpenseWidget extends StatelessWidget {
  const SplitExpenseWidget({
    super.key,
    required this.expense,
  });

  final SplitExpense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: Colors.grey, shape: BoxShape.circle),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              Text(user1.name),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [TextLabel(text: expense.title), Text(expense.date)],
          ),
          Row(
            children: [
              Text(
                expense.amount.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(" ريال ")
            ],
          )
        ],
      ),
    );
  }
}

class BalanceView extends StatelessWidget {
  const BalanceView({super.key});

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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextTitle(
                text: "الرصيد الإجمالي",
                color: Colors.white,
              ),
              TextTitle(
                text: "285 ريال",
                color: Colors.white,
              )
            ],
          ),
        ),
        const MemberExpenseWidget(),
        const Divider(),
        const MemberExpenseWidget(),
        const Divider(),
        const MemberExpenseWidget(),
        const Divider()
      ],
    );
  }
}

class MemberExpenseWidget extends StatelessWidget {
  const MemberExpenseWidget({
    super.key,
  });

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
              Text(user1.name),
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
