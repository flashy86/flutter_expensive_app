// -----IMPORT PACKAGES EXTERNES--------------------
import 'package:flutter/material.dart';
// -----IMPORTS FICHIERS DART DU PROJET ------------
import '../widgets/new_transation.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';

// ----- CLASSE UTILISANT STATEFULWIDGET -------------

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

// ----- CLASSE PRIVEE MANIPULANT LE STATE -----------
class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Apple Computer',
      amount: 718.09,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'IpadPro',
      amount: 1218.58,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
