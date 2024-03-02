import 'package:hackathon/app/profile/model/user.dart';

class SplitExpense {
  final int id;
  final String title;
  final double amount;
  final String date;
  final int splitId;
  final User user;

  SplitExpense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.splitId,
    required this.user,
  });

  factory SplitExpense.fromJson(Map<String, dynamic> json) => SplitExpense(
        id: json["id"],
        title: json["title"],
        amount: json["amount"]?.toDouble(),
        date: json["date"],
        splitId: json["split_id"],
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
        "date": date,
        "split_id": splitId,
        "user_id": user.id,
      };
}
