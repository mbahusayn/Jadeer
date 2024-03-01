class SplitExpense {
  final int id;
  final String title;
  final double amount;
  final String date;
  final int splitId;
  final int userId;

  SplitExpense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.splitId,
    required this.userId,
  });

  factory SplitExpense.fromJson(Map<String, dynamic> json) => SplitExpense(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        date: json["date"],
        splitId: json["split_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "date": date,
        "split_id": splitId,
        "user_id": userId,
      };
}
