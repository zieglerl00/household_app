import 'package:flutter/material.dart';
import 'package:household/ShoppingList.dart';
import 'package:household/constants.dart';

import 'base_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final itemController = TextEditingController();
  final quantityController = TextEditingController();

  int currentIndex = 0;
  String? item;
  String? quantity;

  void sendData(name, quantity) async {
    var response = await BaseClient().post("add/", name, quantity).catchError((e){print(e);});
    print(response);
  }

  Widget _checkScreens() {
    if (currentIndex == 0) {
      return FloatingActionButton(
        backgroundColor: colorGreenLight,
        elevation: 12,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: colorGrey,
                    title: const Text(
                      "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    content: SizedBox(
                      height: 180,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: itemController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1)),
                                  hintText: "Ware",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: quantityController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1)),
                                  hintText: "Quantity",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {

                            Navigator.pop(context);

                            setState(() {
                              item = itemController.text;
                              quantity = quantityController.text;
                            });
                            sendData(item, quantity);
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ))
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      );
    }
    return Container();
  }

  final screens = [
    const ShoppingList(),
    const Center(
      child: Text(
        "Info",
        style: TextStyle(fontSize: 60),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _checkScreens(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkModeBackground,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorGreenLight,
        unselectedItemColor: colorLightGrey,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            label: "Einkaufsliste",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work,
            ),
            label: "Todo's",
          )
        ],
      ),
    );
  }
}
