import 'package:cardnesia/firebase_options.dart';
import 'package:cardnesia/utils/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EncapsuladorFirebase extends StatelessWidget {
  final Widget page;
  const EncapsuladorFirebase({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Scaffold(
              body: Center(
                child: Text(
                  'Something went wrong with firebase bro..',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          case ConnectionState.waiting:
            return const Scaffold(
              body: Loading(
                  message: 'Inicializando configurações de servidor...'),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            return page;
        }
      },
    );
  }
}
