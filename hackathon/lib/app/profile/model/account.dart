import 'package:hackathon/app/auth/screens/loading_screen.dart';

class Account {
  final String accountTitle;
  final double monthlyIncome;
  final double balance;
  final double totalBudget;

  Account(
      {required this.accountTitle,
      required this.monthlyIncome,
      required this.balance,
      required this.totalBudget});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountTitle: json['account_title'],
        monthlyIncome: json['monthly_income']?.toDouble(),
        balance: json['balance']?.toDouble(),
        totalBudget: json['total_budget']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "account_title": accountTitle,
        "monthly_income": monthlyIncome,
        "balance": balance,
        "total_budget": totalBudget,
        "user_id": currentUser.id,
      };
}
