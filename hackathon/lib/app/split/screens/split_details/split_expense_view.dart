import 'package:flutter/material.dart';
import 'package:hackathon/app/auth/screens/loading_screen.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/home/widgets/date_picker.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/model/split_expense.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';

class SplitExpenseView extends StatefulWidget {
  const SplitExpenseView({
    super.key,
    required this.split,
  });
  final Split split;

  @override
  State<SplitExpenseView> createState() => _SplitExpenseViewState();
}

class _SplitExpenseViewState extends State<SplitExpenseView> {
  final TextEditingController title = TextEditingController(),
      amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextLabel(text: "النفقات الحالية"),
            AddIconButton(onPressed: () {
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
                                TextFieldWidget(hint: "", controller: title),
                                const TextLabel(text: "المبلغ"),
                                TextFieldWidget(
                                  hint: "",
                                  controller: amount,
                                  isNumber: true,
                                ),
                                const TextLabel(text: "التاريخ"),
                                height8,
                                const DatePickerWidget(),
                                height48,
                                ElevatedButtonWidget(
                                    onPressed: () async {
                                      await SupabaseFunctions()
                                          .addSplitExpense({
                                        "title": title.text,
                                        "amount": amount.text,
                                        "date": selectedDate,
                                        "split_id": widget.split.id,
                                        "user_id": currentUser.id
                                      });
                                      Navigator.pop(context);
                                    },
                                    text: "إضافة")
                              ],
                            ),
                          ),
                        ),
                      )).then((value) {
                setState(() {});
              });
            }),
          ],
        ),
        const Divider(),
        FutureBuilder(
            future: SupabaseFunctions().getSplitExpenses(widget.split.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SplitExpense> list = snapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return SplitExpenseWidget(expense: list[index]);
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
              Text(expense.user.name.toString()),
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
