import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todify/viewmodel/services/home/home_services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            builder: (context, value, child) => ListView.builder(
              itemCount: value.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                    title: Text(
                      value[index],
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    subtitle: FutureBuilder(
                      future: HomeServices().fetchDate(),
                      builder: (context, date) {
                        if (date.data == null) {
                          return Text(
                              DateFormat.yMMMd().format(DateTime.now()));
                        } else {
                          return Text(
                            date.data![index],
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primary.withOpacity(.4),
                            ),
                          );
                        }
                      },
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            HomeServices().showEdit(context, value[index]);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            HomeServices().removeTask(value[index]);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeServices().addTask(context);
          setState(() {
            HomeServices().fetchTask();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
