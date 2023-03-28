import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:note_app_v1/state/action.dart';
import 'package:note_app_v1/state/store.dart';

class DetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailsPage({super.key, required this.data});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController subtitleController =
        TextEditingController(text: "${widget.data['description']}");
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: store.state.darkMode == true
              ? const Color.fromARGB(255, 0, 38, 104)
              : Colors.blue[700],
          title: Text(
            "${widget.data['title']}",
            style:
                const TextStyle(fontFamily: 'roboto_slab', fontWeight: FontWeight.w500),
          )),
      body: Container(
        color: store.state.darkMode == true ? Colors.black : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                  color: store.state.darkMode == true ? Colors.white : Colors.black),
              decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      store.state.darkMode == true ? Colors.grey[600] : Colors.grey[300]),
              enabled: isEditing,
              controller: subtitleController,
              maxLines: 8,
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: store.state.darkMode == true
                            ? Colors.red[800]
                            : Colors.red[500],
                        foregroundColor: Colors.white,
                        fixedSize: const Size(70, 30)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Item?"),
                            content:
                                const Text("Are you sure you want to delete this item?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  void deleteData(Database database, dynamic id) async {
                                    await database
                                        .rawQuery("DELETE FROM note WHERE id = $id");
                                    List<Map<String, dynamic>> newData =
                                        await database.rawQuery("SELECT * FROM note");
                                    store.dispatch(setData(data: newData));
                                  }

                                  deleteData(store.state.database!, widget.data['id']);
                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.blue,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Data Deleted',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    dismissDirection: DismissDirection.endToStart,
                                  );
                                  Navigator.popUntil(context, ModalRoute.withName('/'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                child: const Text('Delete'),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.delete),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: store.state.darkMode == true
                            ? Colors.blue[800]
                            : Colors.blue[500],
                        foregroundColor: Colors.white,
                        fixedSize: const Size(50, 30)),
                    onPressed: () {
                      if (isEditing == false) {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      } else {
                        void updateData(
                            Database database, String subtitle, dynamic id) async {
                          await database.rawQuery(
                              "UPDATE note SET description = '$subtitle' WHERE id = $id");
                          List<Map<String, dynamic>> newData =
                              await database.rawQuery("SELECT * FROM note");
                          store.dispatch(setData(data: newData));
                        }

                        updateData(store.state.database!, subtitleController.text,
                            widget.data['id']);
                        const snackBar = SnackBar(
                          backgroundColor: Colors.blue,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Data Updated',
                            style: TextStyle(color: Colors.white),
                          ),
                          dismissDirection: DismissDirection.endToStart,
                        );
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Icon(isEditing == false ? Icons.edit : Icons.done),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
