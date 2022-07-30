import 'package:cardnesia/game/hud.dart';
import 'package:cardnesia/models/jogador.dart';
import 'package:cardnesia/widgets/campo_de_batalha.dart';
import 'package:cardnesia/widgets/campo_de_preparacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class Partida extends StatefulWidget {
  final Jogador j1;
  final Jogador j2;
  final int manaInicial;
  const Partida({
    required this.j1,
    required this.j2,
    this.manaInicial = 1,
    Key? key,
  }) : super(key: key);

  @override
  State<Partida> createState() => _PartidaState();
}

class _PartidaState extends State<Partida> with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);
  int jogadorAtual = 1;
  get j1 => jogadorAtual == 1 ? widget.j1 : widget.j2;
  get j2 => jogadorAtual == 2 ? widget.j1 : widget.j2;

  @override
  void initState() {
    widget.j1.mana = widget.manaInicial;
    widget.j2.mana = widget.manaInicial;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: _hudDeJogador(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.settings),
          ),
        ),
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hud2(j2, doOponente: true),
                  _passarAVez(),
                  Hud2(j1),
                ],
              ),
            ),
            Ink(
              width: 2,
              color: Colors.black12,
              child: const Center(),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  CampoDePreparo(j1),
                  CampoDeBatalha(j1),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabController.index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications),
              label: 'Preparo',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.crosshair),
              label: 'Batalha',
            )
          ],
          onTap: (index) => setState(() => tabController.index = index),
        ),
      ),
    );
  }

  Center _passarAVez() {
    return Center(
        child: Material(
      color: Colors.black12,
      elevation: 4,
      child: InkWell(
          onTap: () => setState(() {
                jogadorAtual = jogadorAtual == 1 ? 2 : 1;
              }),
          child: const Icon(Icons.arrow_upward)),
    ));
  }

  Builder hud1() {
    return Builder(
        builder: (context) => Material(
              elevation: 6,
              color: Colors.black38,
              child: InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.arrow_forward_ios),
                )),
              ),
            ));
  }

  Drawer _hudDeJogador() {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text((j1).nome),
                ),
                ListTile(
                  leading: const Text('Vida:'),
                  title: Text(
                    '${(j1).vida}',
                  ),
                ),
                ListTile(
                  leading: const Text('Mana:'),
                  title: Text(
                    '${(j1).mana}',
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Builder(
            builder: (context) {
              return ListTile(
                title: const Text('Sair'),
                leading: const Icon(Icons.logout_rounded),
                onTap: () {
                  if (Scaffold.of(context).isDrawerOpen) {
                    Navigator.pop(context);
                  }
                  Navigator.pop(context);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
