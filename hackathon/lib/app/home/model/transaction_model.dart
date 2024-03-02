import 'package:hackathon/app/auth/screens/loading_screen.dart';

class Transaction {
  final int id;
  final String title;
  final String date;
  final double amount;
  final String type;
  final String category;

  Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        amount: json["amount"]?.toDouble(),
        type: json["type"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "amount": amount,
        "type": type,
        "category": category,
        "user_id": currentUser.id
      };
}
