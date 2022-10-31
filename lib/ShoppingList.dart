import 'package:flutter/material.dart';
import 'package:household/MySquare.dart';
import 'package:household/base_client.dart';
import 'package:household/constants.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  late Future<dynamic> dataFuture;

  @override
  void initState() {
    super.initState();

    dataFuture = fetchData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData();
    });
  }

  void deleteData(id) async {
    var response =
        await BaseClient().delete("delete/", id.toString()).catchError((e) {
      print(e);
    });
    print(response);
  }

  Future<List> fetchData() async {
    var response = await BaseClient().get("").catchError((e) {
      print(e);
    });
    if (response == null) return [];
    return response as List;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkModeBackground,
      child: FutureBuilder(
          future: dataFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Text("$error");
            } else if (snapshot.hasData) {
              List data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // return MySquare(id: data[index]["id"] ,itemName: data[index]["name"], quantity: data[index]["quantity"], data: data, index: index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: darkModeSquares,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(141, 141, 141, 0.4),
                            spreadRadius: 2,
                            blurRadius: 4,
                            // offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 90,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  data[index]["name"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  data[index]["quantity"].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      deleteData(data[index]["id"]);
                                      data.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.remove_circle_sharp)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: colorWhite,
              ));
            }
          }),
    );
  }
}
