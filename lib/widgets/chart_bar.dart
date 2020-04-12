import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String Label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.Label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: <Widget>[
          Container(
            height: constrains.maxHeight * 0.14,
            child: FittedBox(
              child: Text("\$${spendingAmount.toStringAsFixed(0)}"),
            ),
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(
            height: constrains.maxHeight * 0.55,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amberAccent[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(
            child: FittedBox(child: Text(Label)),
            height: constrains.maxHeight * 0.15,
          ),
        ],
      );
    });
  }
}
