import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime _dateSelected;
  bool _isPickedDate = false;

  void _submitData() {
    if(_dateSelected == null){
      setState(() {
        _isPickedDate = true;
      });
    }
    if(_formKey.currentState.validate()){
      widget.addTransaction(
          stateTitle.text,
          double.parse(stateAmount.text),
          _dateSelected,
      );

      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _dateSelected = pickedDate;
      });
    });
  }

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
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Text(_dateSelected == null ?
                        "No date choose" :
                        DateFormat.yMd().format(_dateSelected)
                      ),
                      FlatButton(
                          onPressed: _presentDatePicker,
                          child: Text("Choose Date"),
                          textColor: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                    onPressed: _submitData,
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
