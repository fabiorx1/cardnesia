import 'package:cardnesia/layouts/grid_de_decks.dart';
import 'package:cardnesia/models/deck.dart';
import 'package:cardnesia/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaDeDecks extends StatefulWidget {
  const PaginaDeDecks({Key? key}) : super(key: key);

  static CollectionReference<Map<String, dynamic>>? collection;
  @override
  State<PaginaDeDecks> createState() => _PaginaDeDecksState();
}

class _PaginaDeDecksState extends State<PaginaDeDecks> {
  late final FirebaseFirestore db;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    super.initState();
  }

  bool streamFlag = true;
  Stream<List<Deck>> stream() async* {
    PaginaDeDecks.collection ??= FirebaseFirestore.instance.collection('decks');
    while (streamFlag) {
      final query = await PaginaDeDecks.collection!.get();
      final decks = [for (final doc in query.docs) Deck.fromMap(doc.data())];
      yield decks;
      streamFlag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Deck>>(
        stream: stream(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Loading(message: 'Carregando Decks...');
            case ConnectionState.active:
            case ConnectionState.done:
              return GradeDeDecks(decks: snapshot.data!);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Novo Deck',
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
