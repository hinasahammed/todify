import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todify/viewmodel/services/search/search_services.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SearchServices().getFilteredTask(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              controller: searchController,
              onChanged: (value) {
                SearchServices().getFilteredTask(value);
              },
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              leading: IconButton(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    SearchServices().storeSearchRecent(searchController.text);
                  }
                },
                icon: const Icon(Icons.search),
              ),
              hintText: "Search ",
            ),
            const Gap(20),
            ValueListenableBuilder(
              valueListenable: SearchServices.searchRecent,
              builder: (context, value, child) => ListView.builder(
                itemCount: value.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer),
                    child: Row(
                      children: [
                        Text(
                          value[index],
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            SearchServices().removeSearchRecent(value[index]);
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            ValueListenableBuilder(
              valueListenable: SearchServices.filteredTask,
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
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
