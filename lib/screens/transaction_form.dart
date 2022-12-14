import 'package:bytebankapp/model/saldo.dart';
import 'package:bytebankapp/model/transactions.dart';
import 'package:bytebankapp/model/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http/webclients/transaction_webclient.dart';
import '../model/contact.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text('Nova transferĂȘncia'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name.toString(),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transferir'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transferenciaValida =
                          _validaTransferencia(context, widget.contact, value);
                      if (transferenciaValida) {
                        final transactionCreated =
                            Transaction(value!, widget.contact);
                        _webClient.save(transactionCreated).then((transaction) {
                          if (transaction != null) {
                            _atualizaEstado(context, transactionCreated, value);
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _atualizaEstado(context, transactionCreated, value) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(transactionCreated);
    Provider.of<Saldo>(context, listen: false).subtrai(value);
  }

  _validaTransferencia(context, contact, value) {
    final _camposPreenchidos = widget.contact != null && value != null;
    final _saldoSuficiente =
        value <= Provider.of<Saldo>(context, listen: false).valor;
    return _camposPreenchidos && _saldoSuficiente;
  }
}
