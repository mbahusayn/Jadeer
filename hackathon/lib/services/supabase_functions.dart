import 'package:hackathon/app/auth/screens/loading_screen.dart';
import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/app/profile/model/account.dart';
import 'package:hackathon/app/profile/model/user.dart' as user;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFunctions {
  final supabase = Supabase.instance.client;

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
      final response = await supabase.from('Transaction').select("*");
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
          .eq("type", "النفقات");

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
          .eq("type", "الإيرادات");

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

  Future<Account> getAccount() async {
    try {
      final response = await supabase
          .from('Account')
          .select("*")
          .match({"user_id": currentUser.id}).single();

      Account account = Account.fromJson(response);

      return account;
    } catch (error) {
      print(error);
      throw const FormatException();
    }
  }
}
