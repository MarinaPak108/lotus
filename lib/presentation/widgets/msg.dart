import 'package:flutter/material.dart';

class myMsg extends StatelessWidget {
  final String msg;

  const myMsg({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        msg,
        style: const TextStyle(color: Colors.green, fontSize: 15),
      ),
      actions: [
        ElevatedButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop(true);
          }, // This will dismiss the dialog
        ),
      ],
    );
  }
}
