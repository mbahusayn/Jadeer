import 'package:flutter/material.dart';
import 'package:hackathon/app/common_widget.dart/add_button.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/profile/model/user.dart';
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/model/split_expense.dart';
import 'package:hackathon/app/split/widgets/split_widget.dart';
import 'package:hackathon/constants/constants.dart';

class SplitScreen extends StatelessWidget {
  const SplitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تقسيم النفقات",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            width: getWidth(context),
            height: 150,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextLabel(text: "التقسيمات الحالية"),
              AddIconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      builder: (context) => Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                              height: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "إنشاء تقسيم النفقات",
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
                                    const TextLabel(text: "الوصف"),
                                    TextFieldWidget(
                                        hint: "",
                                        controller: TextEditingController()),
                                    height48,
                                    ElevatedButtonWidget(
                                        onPressed: () {}, text: "إضافة")
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
              ),
            ],
          ),
          const Divider(),
          SplitWidget(
            split: split,
          ),
          const Divider(),
          SplitWidget(
            split: split,
          ),
          const Divider(),
        ]),
      ),
    );
  }
}

Split split = Split(
    id: 1,
    title: "Dubai Trip",
    totalBalance: 7000,
    description: "description",
    ownerId: 1);

SplitExpense splitExpense1 = SplitExpense(
    id: 1,
    title: "فندق",
    amount: 200,
    date: "Feb 3, 2024",
    splitId: 1,
    userId: 1);

SplitExpense splitExpense2 = SplitExpense(
    id: 2,
    title: "مطعم",
    amount: 50,
    date: "Feb 4, 2024",
    splitId: 1,
    userId: 2);

User user1 = User(
    id: 1,
    name: "محمد صالح",
    username: "mohammed_saleh",
    email: "mohammed_saleh@gmail.com");

User user2 = User(
    id: 2, name: "خالد علي", username: "Kh_Ali", email: "khaled@gmail.com");
