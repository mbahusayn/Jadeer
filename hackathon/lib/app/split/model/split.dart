class Split {
  final int id;
  final String title;
  final double totalBalance;
  final String description;
  final int ownerId;

  Split({
    required this.id,
    required this.title,
    required this.totalBalance,
    required this.description,
    required this.ownerId,
  });

  factory Split.fromJson(Map<String, dynamic> json) => Split(
        id: json["id"],
        title: json["title"],
        totalBalance: json["total_balance"],
        description: json["description"],
        ownerId: json["owner_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "totalBalance": totalBalance,
        "description": description,
        "owner_id": ownerId,
      };
}
