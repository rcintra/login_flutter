

import 'package:flutter/material.dart';

alert(BuildContext context, String title, String texto) {
  showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(texto),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
  );
}