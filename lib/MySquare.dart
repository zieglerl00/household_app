import 'package:flutter/material.dart';
import 'package:household/constants.dart';

import 'base_client.dart';

class MySquare extends StatelessWidget {
  const MySquare({
    super.key,
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.data,
    required this.index,
  });

  final int id;
  final String itemName;
  final int quantity;
  final List data;
  final int index;

  @override
  Widget build(BuildContext context) {

    void deleteData() async {
      var response = await BaseClient().delete("delete/", id.toString()).catchError((e){print(e);});
      print(response);
    }

    return Container(
      margin: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.95,
      height: 120,
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
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 20),
                  child: Text(
                    "$itemName",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 20),
                  child: Text(
                    "$quantity",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ButtonBar(
              children: [
                IconButton(
                    color: Colors.white,
                    onPressed: () {
                      deleteData();
                    },
                    icon: Icon(Icons.remove_circle_sharp)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
