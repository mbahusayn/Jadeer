import 'package:hackathon/app/home/model/transaction_model.dart';
import 'package:hackathon/app/profile/model/user.dart' as user;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFunctions {
  final supabase = Supabase.instance.client;
  /*
  Future<List<Course>> getCourses() async {
    final List data = await Supabase.instance.client
        .from('Course')
        .select('id, name, Teacher(name)')
        .order('id', ascending: true); // query from 2 relational tables by FK

    log(data.toString());

    List<Course> coursesList = [];
    for (var element in data) {
      coursesList.add(Course.fromJson(element));
    }

    return coursesList;
  }

  //---
  Future<List<Student>> getStudents({int? courseId}) async {
    List data = [];
    if (courseId != null) {
      //get students by course id
      data = await Supabase.instance.client
          .from('Student')
          .select(
              '*, StrudentCourse!inner()') // inner join 2 relational tables by FK
          .eq('StrudentCourse.course_id', courseId); // filter by course id

      log(data.toString());
    } else {
      // get all students
      data = await Supabase.instance.client.from('Student').select('*');
    }

    List<Student> studentsList = [];
    for (var element in data) {
      studentsList.add(Student.fromJson(element));
    }
    return studentsList;
  }
  //---

  addNewCourse(Map body) async {
    final supabase = Supabase.instance.client;
    final data = await supabase.from('Course').insert(body).select();

    print(data);
  }

  addNewStudent(Map body) async {
    final supabase = Supabase.instance.client;
    await supabase.from('Student').insert(body);
  }

  updateCourse({required int id, required String newName}) async {
    final supabase = Supabase.instance.client;
    await supabase.from('Course').update({"name": newName}).eq("id", id);
  }

  deleteCourset(int id) async {
    final supabase = Supabase.instance.client;
    await supabase.from('StrudentCourse').delete().eq('course_id', id);
    await supabase.from('Course').delete().eq('id', id);
  }
  */

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
}
