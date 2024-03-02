import 'package:hackathon/app/auth/screens/loading_screen.dart';
import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/app/profile/model/account.dart';
import 'package:hackathon/app/profile/model/user.dart' as user;
import 'package:hackathon/app/split/model/split.dart';
import 'package:hackathon/app/split/model/split_expense.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFunctions {
  final supabase = Supabase.instance.client;

//-------------- AUTH --------------
  addNewUser(Map body) async {
    try {
      await supabase.from('User').insert(body);
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<user.User> getLoggedInUser() async {
    try {
      final data = await supabase
          .from('User')
          .select("*")
          .eq("email", supabase.auth.currentUser!.email!)
          .single();

      user.User userObject = user.User.fromJson(data);

      return userObject;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

//-------------- TRANSACTIONS --------------
  addTransaction(Map body) async {
    try {
      await supabase.from('Transaction').insert(body);
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<List<Transaction>> getAllTransaction() async {
    try {
      List<Transaction> list = [];
      final response = await supabase
          .from('Transaction')
          .select("*")
          .eq("user_id", currentUser.id);
      for (var element in response) {
        list.add(Transaction.fromJson(element));
      }

      return list;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<Map<String, List<Transaction>>> getAllTransactionOrededByDate() async {
    try {
      final response = await supabase
          .from('Transaction')
          .select("*")
          .eq("user_id", currentUser.id)
          .order("date", ascending: false);

      final Map<String, List<Transaction>> groupedTransactions = {};

      for (final element in response) {
        final String date = element["date"];

        if (!groupedTransactions.containsKey(date)) {
          groupedTransactions[date] = [];
        }
        groupedTransactions[date]!.add(Transaction.fromJson(element));
      }
      groupedTransactions.forEach((day, images) {
        images.sort((a, b) => b.date.compareTo(a.date));
      });

      return groupedTransactions;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  deleteTransaction(int id) async {
    try {
      await supabase.from('Transaction').delete().eq("id", id);
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<double> getTotalExpenses() async {
    try {
      final data = await supabase
          .from('Transaction')
          .select("amount")
          .eq("type", "النفقات")
          .eq("user_id", currentUser.id);

      double sum = 0;
      for (var element in data) {
        sum += element["amount"];
      }

      return sum;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<double> getTotalIncomes() async {
    try {
      final data = await supabase
          .from('Transaction')
          .select("amount")
          .eq("type", "الإيرادات")
          .eq("user_id", currentUser.id);

      double sum = 0;
      for (var element in data) {
        sum += element["amount"];
      }

      return sum;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

//-------------- ACCOUNT --------------
  addAccount(Map body) async {
    try {
      await supabase.from('Account').insert(body);
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<List<Account>> getAllAccounts() async {
    try {
      List<Account> list = [];
      final response = await supabase
          .from('Account')
          .select("*")
          .eq("user_id", currentUser.id);

      for (var element in response) {
        list.add(Account.fromJson(element));
      }

      return list;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<Account?> getAccount() async {
    try {
      final response = await supabase
          .from('Account')
          .select("*")
          .match({"user_id": currentUser.id});
      if (response.isNotEmpty) {
        Account account = Account.fromJson(response.first);
        return account;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  //-------------- SPLIT --------------
  addSplit(Map body) async {
    try {
      await supabase.from('Split').insert(body);
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<List<Split>> getAllSplits() async {
    try {
      List<Split> list = [];
      final response = await supabase.from('Split').select("*");

      for (var element in response) {
        if (((element["members_ids"]) as List).contains(currentUser.id)) {
          list.add(Split.fromJson(element));
        }
      }

      return list;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  addSplitExpense(Map body) async {
    try {
      await supabase.from('SplitExpense').insert(body);
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<List<SplitExpense>> getSplitExpenses(int splitId) async {
    try {
      List<SplitExpense> list = [];
      final response = await supabase
          .from('SplitExpense')
          .select("*,User(*)")
          .eq("split_id", splitId)
          .order("date");

      for (var element in response) {
        list.add(SplitExpense.fromJson(element));
      }

      return list;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }

  Future<List<user.User>> getSplitMembers(int splitId) async {
    try {
      List<user.User> list = [];
      final response = await supabase
          .from('Split')
          .select("members_ids")
          .eq("id", splitId)
          .single();

      final users = await supabase
          .from('User')
          .select("*")
          .inFilter("id", response["members_ids"]);

      for (var element in users) {
        list.add(user.User.fromJson(element));
      }
      return list;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }
}
