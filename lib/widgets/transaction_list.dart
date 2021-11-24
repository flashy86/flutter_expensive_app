// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //gère le datetime

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                padding: const EdgeInsets.all(10),
                child: Text(
                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat().add_yMMMd().format(transactions[index].date),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ));
        },
        itemCount: transactions.length,
      ),
    );
  }
}
