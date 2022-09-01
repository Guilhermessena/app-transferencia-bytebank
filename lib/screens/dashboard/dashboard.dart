import 'package:bytebankapp/model/saldo.dart';
import 'package:bytebankapp/screens/dashboard/saldo.dart';
import 'package:bytebankapp/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contacts_list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text('Bytebank'),
      ),
      body: Column(
        children: <Widget>[
          // Consumer<Saldo>(builder: (context, saldo, child) {
          //   return ElevatedButton(
          //       onPressed: () {
          //         saldo.adiciona(10);
          //       },
          //       child: Text('Adiciona'));
          // }),
          Align(
            child: SaldoCard(),
            alignment: Alignment.topLeft,
          ),
          Container(
            height: 100,
            width: double.maxFinite,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _FeatureItem(
                  'Transferência',
                  Icons.monetization_on,
                  onClick: () => _showContactsList(context),
                ),
                _FeatureItem(
                  'Extrato',
                  Icons.description,
                  onClick: () => _showTransactionsList(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsList(),
      ),
    );
  }

  _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionList(),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function? onClick;

  _FeatureItem(
    this.name,
    this.icon, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick!(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
