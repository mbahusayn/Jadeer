import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/app/common_widget.dart/button.dart';
import 'package:hackathon/app/common_widget.dart/text_label.dart';
import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/app/home/screens/home_screen.dart';
import 'package:hackathon/app/home/widgets/date_picker.dart';
import 'package:hackathon/app/common_widget.dart/text_field.dart';
import 'package:hackathon/constants/data.dart';
import 'package:hackathon/utils/functions.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TextEditingController tite = TextEditingController(),
      amount = TextEditingController(text: "100");

  String dropdownisExpenseueCategory = categories.first;

  DateTime selectedDate = DateTime.now();
  String dropdownisExpenseue = categories.first;
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إضافة معاملة جديدة",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: ColorsApp.primaryColor,
      ),
      body: Stack(children: [
        Container(
          width: getWidth(context),
          height: getHeight(context),
          color: ColorsApp.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              height16,
              Container(
                width: getWidth(context),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 144, 196, 190),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "فئة المعاملة",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: dropdownisExpenseue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 4,
                        underline: Container(),
                        style: const TextStyle(
                            color: Colors.black, fontFamily: "IBMPlexSans"),
                        onChanged: (String? isExpenseue) {
                          setState(() {
                            dropdownisExpenseue = isExpenseue!;
                          });
                        },
                        items: categories.map<DropdownMenuItem<String>>(
                            (String isExpenseue) {
                          return DropdownMenuItem<String>(
                            value: isExpenseue,
                            child: Row(
                              children: [
                                categoryIcon(isExpenseue),
                                width8,
                                Text(isExpenseue),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              height16,
              const Text(
                "كم المبلغ ؟",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  SizedBox(
                    width: getWidth(context) * 0.25,
                    child: TextField(
                      controller: amount,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorColor: Colors.white,
                      cursorHeight: 30,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: ColorsApp.primaryColor,
                          border: InputBorder.none),
                    ),
                  ),
                  const Text(
                    "ريال",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ]),
          ),
        ),
        Positioned(
          top: 200,
          child: Container(
            height: getHeight(context) * 0.65,
            width: getWidth(context),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextLabel(
                          text: "اسم المعاملة",
                        ),
                        TextFieldWidget(hint: "مطعم", controller: tite),
                        height16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextLabel(
                              text: "نوع المعاملة",
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpense = !isExpense;
                                });
                              },
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: ColorsApp.secondaryColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: isExpense
                                                ? Colors.white
                                                : ColorsApp.secondaryColor),
                                        child: Center(
                                            child: Text(
                                          'نفقة',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isExpense
                                                  ? Colors.black
                                                  : Colors.white),
                                        )),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: isExpense
                                                ? ColorsApp.secondaryColor
                                                : Colors.white),
                                        child: Center(
                                            child: Text(
                                          'إيراد',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isExpense
                                                  ? Colors.white
                                                  : Colors.black),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        height16,
                        const TextLabel(
                          text: "التاريخ",
                        ),
                        height16,
                        const DatePickerWidget(),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButtonWidget(
                      onPressed: () {
                        Transaction newTransaction = Transaction(
                            title: tite.text,
                            amount: double.parse(
                                amount.text.isEmpty ? "1" : amount.text),
                            type: isExpense ? "النفقات" : "الإيرادات",
                            category: dropdownisExpenseueCategory,
                            date:
                                "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}");
                        transactions.add(newTransaction);
                        Navigator.pop(context);
                      },
                      text: "إضافة",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
