import 'package:sqflite/sqflite.dart';

class setDatabase {
  Database database;
  setDatabase({required this.database});
}

class setData {
  List<Map<String, dynamic>> data;
  setData({required this.data});
}

class setCurrentData {
  Map<String, dynamic> currentData;
  setCurrentData({required this.currentData});
}

class setDarkMode {}
