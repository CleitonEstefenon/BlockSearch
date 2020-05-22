import 'package:flutter/material.dart';
import 'package:projeto/src/models/transaction-dashboard.dart';
import 'package:projeto/src/util/date_utils.dart';
import 'package:projeto/src/views/chart.dart';
import 'package:projeto/src/services/dashboard.dart';
import 'floatButtons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TransactionDashboard> _transactions = [];

  ScrollController _scrollController = new ScrollController();

  int offset = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getAllTransactions();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (offset < count) {
          setState(() {
            offset += 10;
          });
          _getAllTransactions();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getAllTransactions() async {
    Dashboard().findAllDocuments(offset: offset, limit: 10).then((response) {
      List<TransactionDashboard> transactions = [];

      for (var transaction in response.data["rows"]) {
        transactions.add(TransactionDashboard.fromJson(transaction));
      }
      setState(() {
        _transactions = [..._transactions, ...transactions];
        count = response.data["count"];
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
            Container(
              height: MediaQuery.of(context).size.height - 236,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  TransactionDashboard transaction = _transactions[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        transaction.confirmations > 6
                            ? "6+"
                            : transaction.confirmations.toString(),
                      ),
                    ),
                    title: transaction.confirmed
                        ? Text(
                            'Documento registrado',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Documento pendente',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                    subtitle: Text(
                      DateUtils.dateToString(
                        date: transaction.createdAt,
                        format: "d MMM y - HH:mm:ss",
                      ),
                    ),
                    trailing: transaction.confirmed
                        ? Icon(Icons.check, color: Colors.blue)
                        : Icon(Icons.clear, color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatButton(),
    );
  }
}
