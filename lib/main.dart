import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:note_app_v1/database.dart';
import 'package:note_app_v1/details.dart';
import 'package:note_app_v1/home.dart';
import 'package:note_app_v1/preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:note_app_v1/state/action.dart';
import 'package:note_app_v1/state/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database database = await DatabaseHelper.createDatabase();
  List<Map<String, dynamic>> data = await database.rawQuery("SELECT * FROM note");
  store.dispatch(setDatabase(database: database));
  store.dispatch(setData(data: data));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: "/",
        routes: {
          "/": (context) => const HomePage(),
          "/details": (context) => DetailsPage(
                data: store.state.currentData,
              ),
          "/preferences": (context) => const PreferencesPage()
        },
      ),
    );
  }
}
