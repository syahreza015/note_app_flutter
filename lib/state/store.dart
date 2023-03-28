import 'package:note_app_v1/state/action.dart';
import 'package:redux/redux.dart';
import 'package:sqflite/sqflite.dart';

class AppState {
  bool darkMode;
  List<Map<String, dynamic>> data;
  Map<String, dynamic> currentData;
  Database? database;
  AppState(
      {required this.database,
      required this.data,
      required this.currentData,
      required this.darkMode});

  factory AppState.initialState() {
    return AppState(database: null, data: [], currentData: {}, darkMode: false);
  }
}

AppState reducer(AppState state, dynamic action) {
  if (action is setDatabase) {
    return AppState(
        database: action.database,
        data: state.data,
        currentData: state.currentData,
        darkMode: state.darkMode);
  } else if (action is setData) {
    return AppState(
        database: state.database,
        data: action.data,
        currentData: state.currentData,
        darkMode: state.darkMode);
  } else if (action is setCurrentData) {
    return AppState(
        database: state.database,
        data: state.data,
        currentData: action.currentData,
        darkMode: state.darkMode);
  } else if (action is setDarkMode) {
    return AppState(
        database: state.database,
        data: state.data,
        currentData: state.currentData,
        darkMode: !state.darkMode);
  }
  return state;
}

final store = Store(reducer, initialState: AppState.initialState());
