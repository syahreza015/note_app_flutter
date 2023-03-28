import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Container(
            alignment: Alignment.centerRight,
            child: const Text(
              "Preferences",
              style: TextStyle(fontFamily: 'roboto_slab', fontWeight: FontWeight.w500),
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue[700], borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text(
                    textAlign: TextAlign.center,
                    "Theme",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'roboto_slab', fontSize: 17),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
