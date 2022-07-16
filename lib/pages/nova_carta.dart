import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/models/dominios.dart';
import 'package:cardnesia/pages/cartas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String? emptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'não suje o banco de dados com cartas falsas...';
  }
  return null;
}

class NovaCarta extends StatefulWidget {
  const NovaCarta({Key? key}) : super(key: key);

  @override
  State<NovaCarta> createState() => _NovaCartaState();
}

class _NovaCartaState extends State<NovaCarta> {
  final GlobalKey<FormState> _formulario = GlobalKey<FormState>();
  late final Map<String, TextEditingController> controllers;
  var dom = Dominios.indefinido;

  @override
  void initState() {
    controllers = {
      Tradutor.titulo: TextEditingController(),
      'custo': TextEditingController(text: '1'),
      'referencia': TextEditingController(),
      Tradutor.descricao: TextEditingController(),
    };
    super.initState();
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  bool _debounce = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Carta')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formulario,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextFormField(
                      controller: controllers[Tradutor.titulo],
                      decoration: InputDecoration(
                        label: Text(toFirstUpper(Tradutor.titulo)),
                      ),
                      validator: emptyValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextFormField(
                      controller: controllers['custo'],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(toFirstUpper('custo')),
                      ),
                      validator: emptyValidator,
                    ),
                  ),
                  DropdownButton<Dominios>(
                    value: dom,
                    items: [
                      for (final valor in Dominios.values)
                        DropdownMenuItem(
                          value: valor,
                          child: Text(valor.name),
                        )
                    ],
                    onChanged: (valor) => dom = valor ?? Dominios.indefinido,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextFormField(
                      controller: controllers[Tradutor.descricao],
                      minLines: 3,
                      maxLines: null,
                      decoration: InputDecoration(
                        label: Text(toFirstUpper(Tradutor.descricao)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextFormField(
                      controller: controllers['referencia'],
                      decoration: InputDecoration(
                        label: Text(toFirstUpper('referência')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: _debounce
                          ? null
                          : () async {
                              _debounce = true;
                              if (_formulario.currentState!.validate()) {
                                final a = await PaginaDeCartas.collection.add({
                                  Tradutor.titulo:
                                      controllers[Tradutor.titulo]!.text,
                                  Tradutor.dominio: dom.name,
                                  'custo':
                                      int.parse(controllers['custo']!.text),
                                  Tradutor.descricao:
                                      controllers[Tradutor.descricao]!.text,
                                });
                              }
                              _debounce = false;
                            },
                      child: const Text('Criar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
