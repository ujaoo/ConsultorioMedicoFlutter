import 'package:flutter/material.dart';

class HistoricoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Pacientes'),
      ),
      body: Center(
        child: Text(
          'Página de Histórico de Pacientes',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}