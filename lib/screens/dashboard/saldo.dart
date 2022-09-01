import 'package:bytebankapp/model/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Consumer<Saldo>(
              builder: (context, valor, child) {
                return Text(
                  valor.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            )));
  }
}
