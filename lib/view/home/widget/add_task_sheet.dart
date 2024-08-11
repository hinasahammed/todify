import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todify/res/components/common/custom_button.dart';
import 'package:todify/res/components/common/custom_textformfied.dart';
import 'package:todify/res/utils/utils.dart';
import 'package:todify/viewmodel/services/home/home_services.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  DateTime? selectedDate;
  final taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      width: size.width,
      height: size.height * .45,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Add Task",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Gap(10),
            CustomTextFormfield(
              controller: taskController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a task name";
                }
                return null;
              },
              fieldName: "Task",
            ),
            const Gap(20),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                isIcon: true,
                icon: Icons.calendar_month,
                onPressed: () async {
                  var date = await HomeServices().selectDate(context);
                  setState(() {
                    selectedDate = date ?? DateTime.now();
                  });
                },
                btnText: selectedDate == null
                    ? "Select a date"
                    : DateFormat.yMMMEd().format(selectedDate!),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                CustomButton(
                  onPressed: () {
                    if (selectedDate == null) {
                      Utils().showFlushToast(
                        context,
                        "Warning",
                        "Select a date",
                      );
                    } else {
                      if (_formKey.currentState!.validate()) {
                        HomeServices().saveTask(
                          taskController.text,
                          context,
                          DateFormat.yMMMEd().format(selectedDate!),
                        );
                      }
                    }
                  },
                  btnText: "Add",
                )
              ],
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
