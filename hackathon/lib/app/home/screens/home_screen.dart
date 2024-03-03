import 'package:flutter/material.dart';
import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/app/home/screens/add_transaction.dart';
import 'package:hackathon/app/home/widgets/switch_account.dart';
import 'package:hackathon/app/home/widgets/transaction_widget.dart';
import 'package:hackathon/app/home/widgets/type_widget.dart';
import 'package:hackathon/app/profile/model/account.dart';
import 'package:hackathon/app/profile/screens/account_screen.dart';
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
  final TextEditingController title = TextEditingController(),
      monthlyIncome = TextEditingController();
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTransactionScreen()))
              .then((value) {
            getTotals();
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
                FutureBuilder(
                    future: SupabaseFunctions().getAccount(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Account account = snapshot.data!;
                        return Center(
                            child:
                                Stack(alignment: Alignment.center, children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: CircularProgressIndicator(
                              backgroundColor: ColorsApp.greyColor,
                              valueColor: const AlwaysStoppedAnimation(
                                  ColorsApp.primaryColor),
                              strokeWidth: 10,
                              value: expensePercentage(
                                      account.totalBudget, account.balance) /
                                  100,
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    account.balance.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  const Text(
                                    " ريال",
                                  )
                                ],
                              ),
                              Text(
                                  "أنفقت ${expensePercentage(account.totalBudget, account.balance).toStringAsFixed(1)} %")
                            ],
                          )
                        ]));
                      } else if (snapshot.hasError) {
                        return SizedBox(
                          height: 150,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    "قم بإضافة حساب للإستفادة من التطبيق "),
                                height8,
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16))),
                                        builder: (context) => AddAccountSheet(
                                            title: title,
                                            monthlyIncome: monthlyIncome)).then(
                                        (value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: ColorsApp.secondaryColor,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: const Text(
                                      "إضافة حساب ",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: CircularProgressIndicator(
                              color: ColorsApp.primaryColor,
                            ),
                          ),
                        );
                      }
                    }),
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
                    future: SupabaseFunctions().getAllTransactionOrededByDate(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map<String, List<Transaction>> transactions =
                            snapshot.data!;
                        return Column(
                          children: [
                            for (var element in transactions.keys)
                              TransactionGrouped(
                                transactions: transactions,
                                date: element,
                              )
                          ],
                        );
                      } else if (snapshot.data == null) {
                        return Container();
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

class TransactionGrouped extends StatelessWidget {
  const TransactionGrouped({
    super.key,
    required this.transactions,
    required this.date,
  });

  final Map<String, List<Transaction>> transactions;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateFormat(date),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: transactions[date]!.length,
          itemBuilder: (context, index) =>
              TransactionWidget(transaction: transactions[date]![index]),
        ),
      ],
    );
  }
}
