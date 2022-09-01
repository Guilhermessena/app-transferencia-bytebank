import 'package:bytebankapp/model/saldo.dart';
import 'package:bytebankapp/model/transferencias.dart';
import 'package:bytebankapp/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Saldo(0),
        ),
        ChangeNotifierProvider(
          create: (context) => Transferencias(),
        )
      ],
      child: BytebankApp(),
    ));

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange[900],
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.orangeAccent[700]),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.orangeAccent[700],
            textTheme: ButtonTextTheme.primary,
          )),
      home: Dashboard(),
    );
  }
}
