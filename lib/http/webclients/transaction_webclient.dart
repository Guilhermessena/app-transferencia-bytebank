import 'dart:convert';

import '../../model/transactions.dart';
import '../webclient.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http('10.0.60.122:8080', 'transactions'))
        .timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response =
        await client.post(Uri.http('10.0.60.122:8080', 'transactions'),
            headers: {
              'Content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
