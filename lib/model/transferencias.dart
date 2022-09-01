import 'package:bytebankapp/model/transactions.dart';
import 'package:flutter/material.dart';

class Transferencias extends ChangeNotifier{
  final List<Transaction> _transferencias = [];

  List<Transaction> get transactions => _transferencias;

  adiciona(Transaction newTransaction){
    transactions.add(newTransaction);

    notifyListeners();
  }
}