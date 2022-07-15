import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;
  const Loading({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 64,
            width: 64,
            child: CircularProgressIndicator(
              semanticsLabel: 'Indicador de Progresso',
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
