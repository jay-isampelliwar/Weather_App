import 'package:flutter/cupertino.dart';

class History extends ChangeNotifier {
  List<String> history_list = [];

  List<String> get getHistory => history_list.toList();
  int get getLength => history_list.length;

  void addItemInHistory(String city) {
    if (!history_list.contains(city)) history_list.add(city);
  }

  void removeItem(int index) {
    history_list.removeAt(index);
    notifyListeners();
  }
}
