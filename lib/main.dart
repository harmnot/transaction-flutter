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
//    Transaction(
//      id: "t1",
//      title: "Electric Bill",
//      amount: 67.8,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: "g3",
//      title: "New Shoes",
//      amount: 98.8,
//      date: DateTime.now(),
//    ),
  ];
  bool _showChart = false;

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
    final $isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
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
    final switchButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Show Chart"),
        Switch(
            value: _showChart,
            activeColor: Colors.orange,
            hoverColor: Colors.lime,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            })
      ],
    );

    Widget _chartBar(double percentSize) {
      return Container(
          height:( MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top ) * percentSize,
          child: Chart(recentTransactions: _recentTransactions)
      );
    }

    final transactionListComponent = Container(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top ) * 0.7,
      child: theTransactions.isEmpty ? Text("ksong") :
      TransactionList(transactions: theTransactions, deleteTransaction: _deleteTransaction)
    );
      return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                 $isLandscape ?
                   switchButton
                  :
                 _chartBar(0.3),
                  _showChart && $isLandscape ?
                  _chartBar(0.7) : transactionListComponent
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

