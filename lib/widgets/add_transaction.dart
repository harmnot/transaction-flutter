import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final Function addTransaction;

  AddTransaction({this.addTransaction});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();

  final stateTitle = TextEditingController();

  final stateAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  controller: stateTitle,
                  decoration: InputDecoration(
                      labelText: "Title"
                  ),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    return val.isEmpty ? "required title" : null;
                  },
                ),
                TextFormField(
                  controller: stateAmount,
                  decoration: InputDecoration(
                      labelText: "Amount"
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (val) {
                    return val.isEmpty ? "required amount" : null;
                  },
                ),
                FlatButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        widget.addTransaction(
                            stateTitle.text,
                            double.parse(stateAmount.text)
                        );

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      "Add transaction",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen
                      ),
                    )
                )
              ],
            ),
          ),
        ),
    );
  }
}
