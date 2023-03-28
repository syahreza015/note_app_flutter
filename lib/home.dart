import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:note_app_v1/components/inputForm.dart';
import 'package:note_app_v1/components/noteCard.dart';
import 'package:note_app_v1/state/action.dart';
import 'package:note_app_v1/state/store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.darkMode,
      builder: (context, vm) => Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: store.state.darkMode == true
                ? const Color.fromARGB(255, 0, 38, 104)
                : Colors.blue[700],
            title: const Text(
              "Note App",
              style: TextStyle(fontFamily: 'roboto_slab', fontWeight: FontWeight.w500),
            )),
        body: Container(
          color: store.state.darkMode == true ? Colors.black : Colors.white,
          height: MediaQuery.of(context).size.height * 1,
          padding: const EdgeInsets.all(5),
          child: StoreConnector<AppState, List<Map<String, dynamic>>>(
            builder: (context, vm) => GridView.builder(
              itemCount: store.state.data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/details");
                    store.dispatch(setCurrentData(currentData: store.state.data[index]));
                  },
                  child: NoteCard(
                    currentData: store.state.data[index],
                  )),
            ),
            converter: (store) => store.state.data,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.green,
          notchMargin: 6,
          color: store.state.darkMode == true
              ? const Color.fromARGB(255, 0, 38, 104)
              : Colors.blue[700],
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  "Note App Version 1.0",
                                  textAlign: TextAlign.center,
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text("Built with flutter"),
                                    Text("Developed By Reza"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              ));
                    },
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Icon(
                        Icons.info,
                        color: store.state.darkMode == true ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: StoreConnector<AppState, bool>(
                        converter: (store) => store.state.darkMode,
                        builder: (context, vm) => Switch(
                          activeColor: Colors.black,
                          value: store.state.darkMode,
                          onChanged: (value) {
                            store.dispatch(setDarkMode());
                          },
                        ),
                      ))
                ],
              )),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: store.state.darkMode == true ? Colors.black : Colors.white,
                  width: 5),
              borderRadius: BorderRadius.circular(100)),
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: store.state.darkMode == true
                ? const Color.fromARGB(255, 0, 38, 104)
                : Colors.blue[700],
            foregroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => const SingleChildScrollView(child: InputForm()),
              );
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
    ;
  }
}
