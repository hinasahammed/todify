import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todify/viewmodel/services/home/home_services.dart';

class SearchServices {
  static ValueNotifier<List<String>> filteredTask =
      ValueNotifier<List<String>>([]);
  static ValueNotifier<List<String>> searchRecent =
      ValueNotifier<List<String>>([]);

  void getFilteredTask(String searchText) {
    filteredTask.value = searchText.isEmpty
        ? HomeServices.allTask.value
        : HomeServices.allTask.value
            .where(
              (element) => element.contains(searchText),
            )
            .toList();
  }

  void storeSearchRecent(String searchedVal) async {
    final pref = await SharedPreferences.getInstance();
    var val = pref.getStringList("searchRecent");
    if (val == null) {
      pref.setStringList("searchRecent", [searchedVal]);
      getSearchRecent();
    } else {
      val.add(searchedVal);
      pref.setStringList("searchRecent", val);
      getSearchRecent();
    }
  }

  void getSearchRecent() async {
    final pref = await SharedPreferences.getInstance();
    var val = pref.getStringList("searchRecent") ?? [];
    searchRecent.value = val;
  }

  void removeSearchRecent(String searchRecent) async {
    final pref = await SharedPreferences.getInstance();
    var val = pref.getStringList("searchRecent") ?? [];
    val.remove(searchRecent);
    pref.setStringList("searchRecent", val);
    getSearchRecent();
  }
}
