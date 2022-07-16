import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/layouts/grid_de_cartas.dart';
import 'package:cardnesia/pages/nova_carta.dart';
import 'package:cardnesia/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaDeCartas extends StatefulWidget {
  const PaginaDeCartas({Key? key}) : super(key: key);

  static late final CollectionReference<Map<String, dynamic>> collection;
  @override
  State<PaginaDeCartas> createState() => _PaginaDeCartasState();
}

class _PaginaDeCartasState extends State<PaginaDeCartas> {
  late final FirebaseFirestore db;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    super.initState();
  }

  late final QuerySnapshot<Map<String, dynamic>> query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartas'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: () async {
          PaginaDeCartas.collection = db.collection('cartas');
          query = await PaginaDeCartas.collection.get();
          return query;
        }(),
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
              return GradeDeCartas(
                cartas: [
                  for (final doc in query.docs) Carta.fromMap(doc.data())
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NovaCarta(),
            ),
          ).then(
            (_) => setState(
              () async => query = await PaginaDeCartas.collection.get(),
            ),
          );
        },
        tooltip: 'Nova Carta',
        child: const Icon(Icons.add_card_rounded),
      ),
    );
  }
}
