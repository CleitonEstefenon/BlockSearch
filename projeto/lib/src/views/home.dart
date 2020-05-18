import 'package:flutter/material.dart';
import 'package:projeto/src/models/transaction-dashboard.dart';
import 'package:projeto/src/views/chart.dart';
import 'package:projeto/src/services/dashboard.dart';
import 'floatButtons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TransactionDashboard> _transactions = [];

  @override
  void initState() {
    super.initState();
    _getTransactions();
  }

  void _getTransactions() async {
    Dashboard().documentsByPeriod().then((response) {
      List<TransactionDashboard> transactions = [];
      for (var transaction in response.data["resp"]["rows"]) {
        transactions.add(TransactionDashboard.fromJson(transaction));
      }
      setState(() {
        _transactions = transactions;
      });
    });
  }

  List<TransactionDashboard> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.createdAt.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "BLOCKSHARE",
        style: TextStyle(
          fontFamily: 'Lena',
          color: Colors.white,
          fontSize: 25.0,
        ),
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Chart(_recentTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatButton(),
    );
  }
}
