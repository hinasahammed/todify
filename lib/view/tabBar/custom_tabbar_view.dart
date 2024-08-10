import 'package:flutter/material.dart';
import 'package:todify/view/home/home_view.dart';
import 'package:todify/view/search/search_view.dart';

class CustomTabbarView extends StatefulWidget {
  const CustomTabbarView({super.key});

  @override
  State<CustomTabbarView> createState() => _CustomTabbarViewState();
}

class _CustomTabbarViewState extends State<CustomTabbarView> {
  List pages = [
    const HomeView(),
    const SearchView(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.primary.withOpacity(.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
