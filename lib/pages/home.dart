import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/agendamento.dart';
import 'package:flutter_application_1/pages/historico.dart';
import 'package:flutter_application_1/pages/perfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(user: {},),
    );
  }
}

class HomePage extends StatelessWidget {
final Map<String, String> user;
  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patomed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare('Agendamento', context, AgendamentoPage(user: {},)),
                SizedBox(width: 20),
                _buildSquare('Histórico', context, HistoricoPage()),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare('Perfil Médico', context, PerfilPage(user: {},)),
                SizedBox(width: 20),
                _buildSquare('Sair', context, PerfilPage(user: {},)),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquare(String title, BuildContext context, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },child: Container(
        width: 159,
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 191, 69, 215),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      hoverColor: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
