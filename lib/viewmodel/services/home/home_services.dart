import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todify/res/utils/utils.dart';
import 'package:todify/view/home/widget/add_task_sheet.dart';

class HomeServices {
  void addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const AddTaskSheet(),
    );
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    final selectDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (selectDate == null) {
      if (context.mounted) {
        Utils().showFlushToast(context, "Error", "Select a date");
      }
    }
    return selectDate;
  }

  void saveTask(
      String taskName, BuildContext context, String selectedDate) async {
    final pref = await SharedPreferences.getInstance();
    var task = pref.getStringList("allTask");
    var date = pref.getStringList("allDates");

    if (task == null || date == null) {
      pref.setStringList("allTask", [taskName]);
      pref.setStringList("allDates", [selectedDate]);
    } else {
      task.add(taskName);
      date.add(selectedDate);
      pref.setStringList("allTask", task);
      pref.setStringList("allDates", date);
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<List<String>> fetchTask() async {
    List<String> task = [];
    final pref = await SharedPreferences.getInstance();
    task = pref.getStringList("allTask") ?? [];
    return task;
  }

  Future<List<String>> fetchDate() async {
    List<String> date = [];
    final pref = await SharedPreferences.getInstance();
    date = pref.getStringList("allDates") ?? [];

    return date;
  }
}
