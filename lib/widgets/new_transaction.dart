// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //en mettant juste return, alors le code s'arrête. Le reste du code ne sera pas atteint.
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    //la méthode pop permet de fermer l'écran le plus haut dans la pile d'affichage.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              //onChanged: (val) {
              //titleInput = val;
              //},
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              //onChanged: (val) => amountInput = val,
            ),
            FlatButton(
              child: const Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
