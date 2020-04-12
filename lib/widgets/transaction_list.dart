import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trythis/models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList({this.transactions, this.deleteTransaction});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: ListTile(
                leading: Container(
                  height: 80,
                  width: 50,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle
                  ),
                  child: FittedBox(
                      child: Text("\$${widget.transactions[index].amount}")
                  ),
                ),
                title: Text(widget.transactions[index].title,
                style: TextStyle(
                    color: Colors.amber[300]
                ),),
                subtitle: Text(DateFormat.yMMMd().format(widget.transactions[index].date)),
                trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.pink,),
                    onPressed: () => widget.deleteTransaction(widget.transactions[index].id),
                ),
              ),
            );
          },
        itemCount: widget.transactions.length,
    );
  }
}
