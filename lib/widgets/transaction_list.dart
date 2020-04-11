import 'package:flutter/material.dart';
import 'package:trythis/models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  TransactionList({this.transactions});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
          itemBuilder: (ctx, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amberAccent,
                radius: 30,
                child: FittedBox(
                    child: Text("\$${widget.transactions[index].amount}")
                ),
              ),
              title: Text(widget.transactions[index].title,
              style: TextStyle(
                  color: Colors.amber[300]
              ),),
            );
          },
        itemCount: widget.transactions.length,
      ),
    );
  }
}
