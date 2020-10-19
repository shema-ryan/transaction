import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.all(10.0),
        elevation: 6.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPct: maxSpending == 0.0
                      ? 0.0
                      : ((data['amount'] as double) / maxSpending),
                ),
              );
            }).toList(),
          ),
        ),
      );
}
