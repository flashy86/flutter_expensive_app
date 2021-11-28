// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import '../models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personnal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red.shade300,
        selectedRowColor: Colors.deepPurpleAccent,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    /*  Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.utc(2021, 11, 23),
    ),
    Transaction(
      id: 't3',
      title: 'Cigarets',
      amount: 21.00,
      date: DateTime.utc(2021, 11, 21),
    ),
    Transaction(
      id: 't4',
      title: 'New Dress',
      amount: 89.98,
      date: DateTime.utc(2021, 11, 20),
    ),
    Transaction(
      id: 't5',
      title: 'Monitor',
      amount: 289.80,
      date: DateTime.utc(2021, 11, 20),
    ),
    Transaction(
      id: 't6',
      title: 'Monthly Groceries',
      amount: 90.58,
      date: DateTime.utc(2021, 10, 23),
    ),
    Transaction(
      id: 't7',
      title: 'Cigarets',
      amount: 21.00,
      date: DateTime.utc(2021, 11, 26),
    ),
    Transaction(
      id: 't8',
      title: 'Meat',
      amount: 35.46,
      date: DateTime.utc(2021, 11, 25),
    ),
    Transaction(
      id: 't9',
      title: 'Bakery',
      amount: 3.5,
      date: DateTime.utc(2021, 11, 26),
    ),
    Transaction(
      id: 't10',
      title: 'Monthly Phone Bill',
      amount: 67.98,
      date: DateTime.utc(2021, 10, 23),
    ), */
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Personnal Expenses',
        style: TextStyle(
          fontFamily: 'OpenSans',
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txListWidget = Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height) *
                0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show Chart!'),
                    Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    ),
                  ]),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
