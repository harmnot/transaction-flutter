import 'package:flutter/material.dart';
import 'package:trythis/models/transaction.dart';
import 'package:trythis/widgets/add_transaction.dart';
import 'package:trythis/widgets/chart.dart';
import 'package:trythis/widgets/transaction_list.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome()
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Transaction> theTransactions = [
    Transaction(
      id: "t1",
      title: "Electric Bill",
      amount: 67.8,
      date: DateTime.now(),
    ),
    Transaction(
      id: "g3",
      title: "New Shoes",
      amount: 98.8,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return theTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime theDate) {
    Transaction newTransaction = Transaction
      (id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: theDate);
    setState(() {
      theTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      theTransactions.removeWhere((transaction) => transaction.id == id );
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) => GestureDetector(
          onTap: () {},
          child: AddTransaction(addTransaction: _addTransaction),
          behavior: HitTestBehavior.opaque,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        ),
      ],
      title: Text("Text Here"),
      backgroundColor: Colors.amberAccent,
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                Container(
                    height:( MediaQuery.of(context).size.height -
                        appBar.preferredSize.height - MediaQuery.of(context).padding.top ) * 0.4,
                    child: Chart(recentTransactions: _recentTransactions)
                ),
                Container(
                  height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height - MediaQuery.of(context).padding.top ) * 0.6,
                  child: theTransactions.isEmpty ? Text("ksong") :
                  TransactionList(transactions: theTransactions, deleteTransaction: _deleteTransaction)
                  ,
                )
              ],
            ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.lightGreen ,
            ),
            backgroundColor: Colors.amberAccent[100],
            onPressed: () => startAddNewTransaction(context)
        ),
      ),
    );
  }
}

