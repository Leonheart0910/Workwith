import 'package:flutter/cupertino.dart';

class Data {
  final String title;
  final String summary;

  Data(this.title, this.summary);
}

class DataList with ChangeNotifier {
  final List<Data> _dataList = [];

  List<Data> get dataList => _dataList;

  void addData(Data newData) {
    _dataList.add(newData);
    notifyListeners();
  }
}