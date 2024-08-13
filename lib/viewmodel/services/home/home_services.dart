import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todify/res/utils/utils.dart';
import 'package:todify/view/home/widget/add_task_sheet.dart';
import 'package:todify/view/home/widget/edit_task_dialogue.dart';

class HomeServices {
  static ValueNotifier<List<String>> allTask = ValueNotifier<List<String>>([]);
  static ValueNotifier<List<String>> allDates = ValueNotifier<List<String>>([]);

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
      getTask();
      getDate();
    } else {
      task.add(taskName);
      date.add(selectedDate);
      pref.setStringList("allTask", task);
      pref.setStringList("allDates", date);
      getTask();
      getDate();
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void getTask() async {
    final pref = await SharedPreferences.getInstance();
    var val = pref.getStringList("allTask") ?? [];
    allTask.value = val;
  }

  void getDate() async {
    final pref = await SharedPreferences.getInstance();
    var val = pref.getStringList("allDates") ?? [];
    allDates.value = val;
  }

  void removeTask(String item) async {
    final pref = await SharedPreferences.getInstance();
    var task = pref.getStringList("allTask") ?? [];
    var date = pref.getStringList("allDates") ?? [];
    var index = task.indexOf(item);
    task.removeAt(index);
    date.removeAt(index);
    pref.setStringList("allTask", task);
    pref.setStringList("allDates", date);
    allTask.value = date;
    allDates.value = date;
  }

  void showEdit(BuildContext context, String task) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: EditTaskDialogue(
              task: task,
            ),
          );
        });
  }

  void updateTask(
    BuildContext context,
    String task,
    String newTask,
  ) async {
    final pref = await SharedPreferences.getInstance();
    var val = pref.getStringList("allTask") ?? [];
    var index = val.indexOf(task);
    print(index);
    val[index] = newTask;
    print(val);
    pref.setStringList("allTask", val);
    Navigator.pop(context);
  }
}
