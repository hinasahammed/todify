import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todify/viewmodel/services/home/home_services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    HomeServices().getTask();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
              valueListenable: HomeServices.allTask,
              builder: (context, value, child) {
                if (value.isEmpty || value == []) {
                  return const Center(child: Text("No task found"));
                } else {
                  return ListView.builder(
                    itemCount: value.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Dismissible(
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: theme.colorScheme.error,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: theme.colorScheme.onError,
                            ),
                            const Gap(20),
                            Text(
                              "Remove",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.onError,
                              ),
                            ),
                            const Gap(20),
                            Icon(
                              Icons.delete,
                              color: theme.colorScheme.onError,
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        var isDismisssible = await HomeServices()
                            .removeTaskConfirm(context, value[index]);
                        return isDismisssible;
                      },
                      key: ValueKey(value),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                            tileColor: theme.colorScheme.primaryContainer,
                            leading: Checkbox(
                              value: true,
                              onChanged: (value) {},
                            ),
                            title: Text(
                              value[index],
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            subtitle: ValueListenableBuilder(
                              valueListenable: HomeServices.allDates,
                              builder: (context, value, child) {
                                if (value.isEmpty || value == []) {
                                  return Text(DateFormat.yMMMd()
                                      .format(DateTime.now()));
                                } else {
                                  return Text(
                                    value[index],
                                    style: theme.textTheme.labelLarge!.copyWith(
                                      color: theme.colorScheme.primary
                                          .withOpacity(.4),
                                    ),
                                  );
                                }
                              },
                            ),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    HomeServices()
                                        .showEdit(context, value[index]);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeServices().addTask(context);
          HomeServices().getTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
