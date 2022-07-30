import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/layouts/grid_de_cartas.dart';
import 'package:cardnesia/pages/nova_carta.dart';
import 'package:cardnesia/utils/loading.dart';
import 'package:cardnesia/widgets/botao_liga_desliga.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaDeCartas extends StatefulWidget {
  const PaginaDeCartas({Key? key}) : super(key: key);

  static CollectionReference<Map<String, dynamic>>? collection;
  @override
  State<PaginaDeCartas> createState() => _PaginaDeCartasState();
}

class _PaginaDeCartasState extends State<PaginaDeCartas> {
  late final FirebaseFirestore db;
  bool mostrarNaoColecionaveis = false;
  @override
  void initState() {
    db = FirebaseFirestore.instance;
    super.initState();
  }

  bool streamFlag = true;
  Stream<List<Carta>> stream() async* {
    PaginaDeCartas.collection ??=
        FirebaseFirestore.instance.collection('cartas');
    while (streamFlag) {
      final query = await PaginaDeCartas.collection!.get();
      final cartas = [for (final doc in query.docs) Carta.fromMap(doc.data())];
      cartas.sort((a, b) => b.custo - a.custo);
      yield cartas;
      streamFlag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cartas'),
          centerTitle: true,
        ),
        body: StreamBuilder<List<Carta>>(
          stream: stream(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Loading(message: 'Carregando Cartas...');
              case ConnectionState.active:
              case ConnectionState.done:
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BotaoLigaDesliga(
                              tituloOff: 'Ver Não Colecionáveis',
                              tituloOn: 'Esconder Não Colecionáveis',
                              ligado: mostrarNaoColecionaveis,
                              onTap: () => setState(() =>
                                  mostrarNaoColecionaveis =
                                      !mostrarNaoColecionaveis))
                        ],
                      ),
                    ),
                    Expanded(
                      child: GradeDeCartas(
                        cartas: snapshot.data!,
                        mostrarNaoColecionaveis: mostrarNaoColecionaveis,
                      ),
                    ),
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
              (_) {
                setState(() {
                  streamFlag = true;
                });
              },
            );
          },
          tooltip: 'Nova Carta',
          child: const Icon(Icons.add_card_rounded),
        ),
      ),
    );
  }
}
