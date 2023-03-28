import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:note_app_v1/state/action.dart';
import 'package:note_app_v1/state/store.dart';

class InputForm extends StatelessWidget {
  const InputForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController subtitleController = TextEditingController();

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20),
      decoration: BoxDecoration(
          color: store.state.darkMode == true ? Colors.black : Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextField(
              style: TextStyle(
                  color: store.state.darkMode == true ? Colors.white : Colors.black),
              autocorrect: false,
              decoration: InputDecoration(
                  label: const Text("Title"),
                  labelStyle: TextStyle(
                      color: store.state.darkMode == true ? Colors.white : Colors.black),
                  filled: true,
                  fillColor:
                      store.state.darkMode == true ? Colors.grey[600] : Colors.grey[300]),
              controller: titleController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextField(
              style: TextStyle(
                  color: store.state.darkMode == true ? Colors.white : Colors.black),
              autocorrect: false,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      store.state.darkMode == true ? Colors.grey[600] : Colors.grey[300],
                  label: const Text("Description"),
                  labelStyle: TextStyle(
                      color: store.state.darkMode == true ? Colors.white : Colors.black)),
              controller: subtitleController,
              maxLines: 8,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FractionallySizedBox(
              widthFactor: 0.7,
              child: ElevatedButton(
                onPressed: () {
                  void insertData(
                      Database database, String title, String description) async {
                    await database.rawQuery(
                        "INSERT INTO note (title, description) VALUES ('$title', '$description')");
                    List<Map<String, dynamic>> newData =
                        await database.rawQuery("SELECT * FROM note");
                    store.dispatch(setData(data: newData));
                  }

                  insertData(store.state.database!, titleController.text,
                      subtitleController.text);
                  const snackBar = SnackBar(
                    backgroundColor: Colors.blue,
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Data Ditambahkan',
                      style: TextStyle(color: Colors.white),
                    ),
                    dismissDirection: DismissDirection.endToStart,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: store.state.darkMode == true
                        ? Colors.blue[900]
                        : Colors.blue[700]),
                child: const Text("Submit"),
              )),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
