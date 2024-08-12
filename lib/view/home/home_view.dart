import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todify/viewmodel/services/home/home_services.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
          child: FutureBuilder(
            future: HomeServices().fetchTask(),
            builder: (context, snapshot) {
              if (snapshot.data == null ||
                  snapshot.data!.isEmpty ||
                  !snapshot.hasData) {
                return Center(
                    child: Text(
                  "No task found",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                        title: Text(
                          snapshot.data![index],
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        subtitle: FutureBuilder(
                          future: HomeServices().fetchDate(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Text(
                                  DateFormat.yMMMd().format(DateTime.now()));
                            } else {
                              return Text(
                                snapshot.data![index],
                                style: theme.textTheme.labelLarge!.copyWith(
                                  color:
                                      theme.colorScheme.primary.withOpacity(.4),
                                ),
                              );
                            }
                          },
                        ),
                        trailing: Wrap(
                          children: [
                            Icon(
                              Icons.edit,
                              color: theme.colorScheme.primary,
                            ),
                            Icon(
                              Icons.delete,
                              color: theme.colorScheme.error,
                            ),
                          ],
                        )),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeServices().addTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
