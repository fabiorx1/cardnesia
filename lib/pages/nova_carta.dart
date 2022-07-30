import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/models/enums.dart';
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
  var raridade = Raridade.devoto;

  @override
  void initState() {
    controllers = {
      Tradutor.titulo: TextEditingController(),
      'custo': TextEditingController(text: '1'),
      'poder': TextEditingController(text: '1'),
      'vida': TextEditingController(text: '1'),
      Tradutor.referencia: TextEditingController(),
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
                  _selecoes(),
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
                    child: _valoresNumericos(),
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
                      onChanged: (value) {
                        final c = controllers['referencia']!;
                        c.text = c.text.replaceAll(' ', '');
                        c.selection = TextSelection.fromPosition(
                            TextPosition(offset: c.text.length));
                      },
                      decoration: InputDecoration(
                          label: Text(toFirstUpper('referência')),
                          helperText:
                              'isso será usado para referenciá-la nas descrições de outras cartas.'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: _debounce
                          ? null
                          : () async {
                              setState(() => _debounce = true);

                              if (_formulario.currentState!.validate()) {
                                await PaginaDeCartas.collection?.add({
                                  Tradutor.titulo:
                                      controllers[Tradutor.titulo]!.text,
                                  Tradutor.dominio: dom.name,
                                  Tradutor.colecionavel: true,
                                  'raridade': raridade.name,
                                  'custo':
                                      int.parse(controllers['custo']!.text),
                                  'poder':
                                      int.parse(controllers['poder']!.text),
                                  'vida': int.parse(controllers['vida']!.text),
                                  Tradutor.descricao:
                                      controllers[Tradutor.descricao]!.text,
                                  Tradutor.referencia:
                                      controllers[Tradutor.referencia]!.text,
                                });
                              }
                              setState(() => _debounce = false);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
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

  Row _selecoes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text('Domínio'),
            DropdownButton<Dominios>(
              value: dom,
              items: [
                for (final valor in Dominios.values)
                  DropdownMenuItem(
                    value: valor,
                    child: Text(valor.name),
                  )
              ],
              onChanged: (valor) => setState(
                () => dom = valor ?? Dominios.indefinido,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Text('Raridade'),
            DropdownButton<Raridade>(
              value: raridade,
              items: [
                for (final valor in Raridade.values)
                  DropdownMenuItem(
                    value: valor,
                    child: Text(valor.name),
                  )
              ],
              onChanged: (valor) => setState(
                () => raridade = valor ?? Raridade.devoto,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _valoresNumericos() {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: controllers['custo'],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(toFirstUpper('custo')),
              ),
              validator: emptyValidator,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: controllers['poder'],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(toFirstUpper('poder')),
              ),
              validator: emptyValidator,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: controllers['vida'],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(toFirstUpper('vida')),
              ),
              validator: emptyValidator,
            ),
          ),
        ),
      ],
    );
  }
}
