import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;

  final double spendingAmount;

  final double spendingPct;

  const ChartBar(
      {@required this.label,
      @required this.spendingAmount,
      @required this.spendingPct});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context ,BoxConstraints constraints){
        return       Column(
          children: <Widget>[
            Container(
                height : constraints.maxHeight * 0.13,
                child: FittedBox(
                    child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(height: constraints.maxHeight*0.05,),
            Container(
              height: constraints.maxHeight * 0.62,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(220, 220, 220, 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey, width: 1)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPct,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight*0.05,),
            Container(
              height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );

  }
}
