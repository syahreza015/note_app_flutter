import 'package:flutter/material.dart';
import 'package:note_app_v1/state/action.dart';
import 'package:note_app_v1/state/store.dart';

class NoteCard extends StatelessWidget {
  final Map<String, dynamic> currentData;
  const NoteCard({super.key, required this.currentData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: store.state.darkMode == true ? Colors.grey[600] : Colors.grey[300],
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: store.state.darkMode == true
                      ? const Color.fromARGB(255, 16, 4, 182)
                      : Colors.blue,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: Center(
                child: Text(
                  "${currentData['title']}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'roboto_slab',
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "${currentData['description']}",
                maxLines: 11,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: store.state.darkMode == true ? Colors.white : Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
