import 'package:flutter/material.dart';
import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/app/home/screens/add_transaction.dart';
import 'package:hackathon/app/home/widgets/switch_account.dart';
import 'package:hackathon/app/home/widgets/transaction_widget.dart';
import 'package:hackathon/app/home/widgets/type_widget.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/constants/data.dart';
import 'package:hackathon/services/supabase_functions.dart';
import 'package:hackathon/style/colors.dart';
import 'package:hackathon/utils/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = duration.first;
  double totalExpenses = 0;
  double totalIncomes = 0;

  @override
  void initState() {
    getTotals();
    super.initState();
  }

  getTotals() async {
    totalExpenses = await SupabaseFunctions().getTotalExpenses();
    totalIncomes = await SupabaseFunctions().getTotalIncomes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getTotals();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTransactionScreen()))
              .then((value) {
            setState(() {});
          });
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
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                builder: (context) => const SwitchAccount());
                          },
                          child: const Row(
                            children: [
                              Text("الحساب الأساسي"),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                      ),
                      //------------ duration
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
                            items: duration
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
                        top: 50,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TypeWidget(
                      type: "النفقات",
                      amount: totalExpenses,
                    ),
                    width16,
                    TypeWidget(
                      type: "الإيرادات",
                      amount: totalIncomes,
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

                FutureBuilder(
                    future: SupabaseFunctions().getAllTransaction(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Transaction> transactions = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateFormat(transactions.first.date),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: transactions.length,
                              itemBuilder: (context, index) =>
                                  TransactionWidget(
                                      transaction: transactions[index]),
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorsApp.primaryColor,
                          ),
                        );
                      }
                    }),
                height48,
                //-------------end
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// List<Transaction> transactions = [
//   Transaction(
//       title: "البيك",
//       date: "2/2/2024",
//       amount: 40,
//       type: "النفقات",
//       category: "مطعم"),
//   Transaction(
//       title: "بارنز كافيه",
//       date: "2/2/2024",
//       amount: 16,
//       type: "النفقات",
//       category: "مقهى"),
//   Transaction(
//       title: "حوالة",
//       date: "2/2/2024",
//       amount: 1000,
//       type: "إيرادات",
//       category: "حوالة"),
//   Transaction(
//       title: "سماعات",
//       date: "2/2/2024",
//       amount: 300,
//       type: "النفقات",
//       category: "تسوق"),
// ];
