import 'package:flutter/material.dart';
import 'package:xmpp_communication/xmpp_communication.dart' as xmpp;

class Messsage extends StatelessWidget {
  final xmpp.Message message;
  final bool fromMe;
  const Messsage({Key? key, required this.message, required this.fromMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width * 0.6;
    final a = fromMe ? Alignment.centerRight : Alignment.centerLeft;
    final c = fromMe ? Colors.blueGrey[100] : Colors.blueGrey[50];
    return Container(
        alignment: a,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                width: w,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            message.from,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 5.0),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(message.body,
                              style: TextStyle(fontSize: 16.0))),
                    ],
                  ),
                ))));
  }
}
