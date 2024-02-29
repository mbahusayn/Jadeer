import 'package:flutter/material.dart';
import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/app/home/screens/add_transaction.dart';
import 'package:hackathon/app/home/widgets/transaction_widget.dart';
import 'package:hackathon/app/home/widgets/type_widget.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

const List<String> list = <String>['شهري', 'يومي', 'سنوي'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddTransactionScreen()));
        },
        backgroundColor: ColorsApp.secondaryColor,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      //-----BODY----
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //------------ account
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                      width: getWidth(context),
                                      height: 200,
                                      child: Column(children: [
                                        const Text("الحساب الحالي"),
                                        const Text("تغيير الحساب"),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: const Text("data"))
                                      ]),
                                    ));
                          },
                          child: const Row(
                            children: [
                              Text("الحساب الأساسي"),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                      ),
                      //------------ period
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: ColorsApp.greyColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 8,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: "IBMPlexSans"),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ]),
                //------------ Circle
                const Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CircularProgressIndicator(
                          backgroundColor: ColorsApp.greyColor,
                          color: ColorsApp.primaryColor,
                          strokeWidth: 10,
                          value: 0.5,
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 35,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "15000",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  " ريال",
                                )
                              ],
                            ),
                            Text("أنفقت 50%")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //------------ types
                height24,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TypeWidget(
                      type: "النفقات",
                      amount: "5500",
                    ),
                    width16,
                    TypeWidget(
                      type: "الإيرادات",
                      amount: "2000",
                    ),
                  ],
                ),
                height16,
                //------------- transaction
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "المعاملات الأخيرة",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                height8,
                const Text(
                  "Feb 17, 2024",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) =>
                      TransactionWidget(transaction: transactions[index]),
                  separatorBuilder: (context, index) => const Divider(),
                )

                //-------------end
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Transaction> transactions = [
  Transaction(
      title: "البيك",
      date: "2/2/2024",
      amount: 40,
      type: "النفقات",
      category: "مطعم"),
  Transaction(
      title: "بارنز كافيه",
      date: "2/2/2024",
      amount: 16,
      type: "النفقات",
      category: "مقهى"),
  Transaction(
      title: "حوالة",
      date: "2/2/2024",
      amount: 1000,
      type: "إيرادات",
      category: "حوالة"),
  Transaction(
      title: "سماعات",
      date: "2/2/2024",
      amount: 300,
      type: "النفقات",
      category: "تسوق"),
];
