import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/src/models/transaction-dashboard.dart';
import 'package:projeto/src/views/chart-bar.dart';

class Chart extends StatelessWidget {
  final List<TransactionDashboard> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      int totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].createdAt.day == weekDay.day;
        bool sameMonth = recentTransactions[i].createdAt.month == weekDay.month;
        bool sameYear = recentTransactions[i].createdAt.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += 1;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0,3),
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0, (acc, tr) => acc + tr['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: (_weekTotalValue == 0)
                    ? 0
                    : (tr['value'] as int) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
