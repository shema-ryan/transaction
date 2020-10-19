import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, selectedDate);
    Navigator.pop(context);
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          width: 100,
          height: 1,
          color: Colors.black45,
        ),
        SizedBox(
          height: 10.0,
        ),
        Card(
          elevation: 0.0,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title,
                  textCapitalization: TextCapitalization.words,
                  onSubmitted: (val) => submitData(),
                  controller: titleController,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (val) => submitData(),
                  cursorColor: Theme.of(context).primaryColor,
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      selectedDate == null
                          ? 'pick a date '
                          : 'pickedDate : ${DateFormat.yMMMd().format(selectedDate)}',
                      style: Theme.of(context)
                          .textTheme
                          // ignore: deprecated_member_use
                          .title
                          .copyWith(
                              fontWeight: FontWeight.normal, fontSize: 17),
                    ),
                    IconButton(
                      iconSize: 20.0,
                      icon: Icon(Icons.calendar_today),
                      onPressed: presentDatePicker,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  elevation: 1.0,
                  child: Text('Add Transaction',
                      style: Theme.of(context).textTheme.button),
                  onPressed: submitData,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
