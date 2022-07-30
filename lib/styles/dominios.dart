import 'package:cardnesia/models/enums.dart';
import 'package:flutter/material.dart';

final Map<Dominios, Color> coresDeDominios = {
  Dominios.submundo: Colors.red.shade800,
  Dominios.natureza: Colors.green.shade700,
  Dominios.indefinido: Colors.grey
};
TextStyle estiloDoCusto(Dominios dom) {
  return TextStyle(
    color: coresDeDominios[dom],
    fontWeight: FontWeight.w900,
    fontSize: 24,
  );
}

TextStyle estiloDoDominio(Dominios dom) {
  return TextStyle(
    color: coresDeDominios[dom],
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
}
