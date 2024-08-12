import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todify/res/components/common/custom_button.dart';
import 'package:todify/res/components/common/custom_textformfied.dart';
import 'package:todify/viewmodel/services/home/home_services.dart';

class EditTaskDialogue extends StatefulWidget {
  final String task;
  const EditTaskDialogue({super.key, required this.task});

  @override
  State<EditTaskDialogue> createState() => _EditTaskDialogueState();
}

class _EditTaskDialogueState extends State<EditTaskDialogue> {
  final taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Container(
      height: size.height * .3,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Edit task",
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(20),
          CustomTextFormfield(
            controller: taskController,
            fieldName: "Task name",
          ),
          const Spacer(),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              CustomButton(
                onPressed: () {
                  HomeServices().updateTask(
                    context,
                    widget.task,
                    taskController.text,
                  );
                },
                btnText: "Update",
              ),
            ],
          )
        ],
      ),
    );
  }
}
