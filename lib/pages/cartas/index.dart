import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/pages/cartas/grid.dart';
import 'package:cardnesia/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartasPage extends StatefulWidget {
  const CartasPage({Key? key}) : super(key: key);

  @override
  State<CartasPage> createState() => _CartasPageState();
}

class _CartasPageState extends State<CartasPage> {
  late final FirebaseFirestore db;
  @override
  void initState() {
    db = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartas'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: db.collection('cartas').get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text(
                  'Something went with reading bro..',
                  textAlign: TextAlign.center,
                ),
              );
            case ConnectionState.waiting:
              return const Loading(message: 'Carregando Cartas...');
            case ConnectionState.active:
            case ConnectionState.done:
              final event =
                  snapshot.data as QuerySnapshot<Map<String, dynamic>>;
              return GradeDeCartas(
                cartas: [
                  for (final doc in event.docs) Carta.fromMap(doc.data())
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Nova Carta',
        child: const Icon(Icons.add_card_rounded),
      ),
    );
  }
}
