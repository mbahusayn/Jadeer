class Split {
  final int id;
  final String title;
  final double totalBalance;
  final List members;
  final int ownerId;

  Split({
    required this.id,
    required this.title,
    required this.totalBalance,
    required this.members,
    required this.ownerId,
  });

  factory Split.fromJson(Map<String, dynamic> json) => Split(
        id: json["id"],
        title: json["title"],
        totalBalance: json["total_balance"]?.toDouble(),
        members: json["members_ids"],
        ownerId: json["owner_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "totalBalance": totalBalance,
        "members_ids": members,
        "owner_id": ownerId,
      };
}
