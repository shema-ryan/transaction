import 'package:flutter/material.dart';
import './chart.dart';
import './newTransactions.dart';
import '../models/transactions.dart';
import './transactions_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transactions',
      theme: ThemeData(
        cursorColor: Colors.brown,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.brown,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title: TextStyle(
                fontFamily: 'Varela',
                fontSize: 15.0,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(fontFamily: 'Varela', fontSize: 17.0))),
        fontFamily: 'Varela',
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final List<Transactions> _userTransaction = [];

  void _userTransactionAdd(
      String txTitle, double txAmount, DateTime datePicked) {
    final Transactions newTx = Transactions(
        date: datePicked,
        amount: txAmount,
        id: DateTime.now().toString(),
        title: txTitle);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void delete(String id, BuildContext context) {
    setState(() {
      _userTransaction.removeWhere((del) {
        return del.id == id;
      });
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('deleted successfully'),
      action: SnackBarAction(
        onPressed: () {},
        label: 'UNDO',
      ),
    ));
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0)),
              ),
              child: GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: NewTransactions(_userTransactionAdd)));
        });
  }

  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    final media = mediaQ.orientation == Orientation.landscape;
    final AppBar appbar = AppBar(
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
            onPressed: () => startNewTransaction(context),
            icon: Icon(Icons.add)),
      ],
      title: Text('Personal Expenses'),
    );
    return Scaffold(
      appBar: appbar,
      floatingActionButton: FloatingActionButton(
        tooltip: 'add a transaction ',
        onPressed: () => startNewTransaction(context),
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (media)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show chart'),
                  Switch(
                    value: showChart,
                    onChanged: (value) {
                      setState(() {
                        showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (media)
              showChart
                  ? Container(
                      height: (mediaQ.size.height -
                              appbar.preferredSize.height -
                              mediaQ.padding.top) *
                          0.75,
                      child: Chart(
                        recentTransactions: _userTransaction,
                      ),
                    )
                  : Container(
                      height: (mediaQ.size.height -
                              appbar.preferredSize.height -
                              mediaQ.padding.top) *
                          0.75,
                      child: TransactionsList(_userTransaction, delete)),
            if (!media)
              Container(
                height: (mediaQ.size.height -
                        appbar.preferredSize.height -
                        mediaQ.padding.top) *
                    0.25,
                child: Chart(
                  recentTransactions: _userTransaction,
                ),
              ),
            if (!media)
              Container(
                  height: (mediaQ.size.height -
                          appbar.preferredSize.height -
                          mediaQ.padding.top) *
                      0.75,
                  child: TransactionsList(_userTransaction, delete)),
          ],
        ),
      ),
    );
  }
}
