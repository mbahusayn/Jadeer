import 'package:flutter/material.dart';
import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/utils/functions.dart';
import 'package:hackathon/style/colors.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
  });
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 225, 225, 225),
              borderRadius: BorderRadius.circular(16)),
          child: categoryIcon(transaction.category)),
      title: Text(
        transaction.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(transaction.category),
      trailing: Text(
        transaction.type == "النفقات"
            ? "- ${transaction.amount} ريال"
            : "+ ${transaction.amount} ريال",
        style: TextStyle(
          color: transaction.type == "النفقات"
              ? Colors.red
              : ColorsApp.ternaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
