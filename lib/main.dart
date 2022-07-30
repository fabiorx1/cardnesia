import 'package:cardnesia/pages/cartas.dart';
import 'package:cardnesia/pages/inicio.dart';
import 'package:cardnesia/utils/firebase_wrapper.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardnésia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: Typography.blackHelsinki,
      ),
      home: const EncapsuladorFirebase(page: PaginaInicio()),
    );
  }
}
