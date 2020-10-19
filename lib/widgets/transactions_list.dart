import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;
  TransactionsList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No Transaction yet ! ! ! ',
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/bmx.jpg',
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enjoy that pic as you adding a transaction',
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FittedBox(
                          child: Text(
                            '\$ ${transactions[index].amount}',
                            // ignore: deprecated_member_use
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transactions[index].title}',
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(fontFamily: 'Varela')),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTx(transactions[index].id, context);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
