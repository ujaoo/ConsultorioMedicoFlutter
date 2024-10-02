import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  final Map<String, String> user;

  PerfilPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meu perfil',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold, 
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.deepPurple,
                ),
                child: Text(
                  'Informações Pessoais',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildField('NOME', user['username'] ?? ''),
              _buildField('ESPECIALIZAÇÃO', user['especializacao'] ?? ''),
              _buildField('TELEFONE', user['telefone'] ?? ''),
              _buildField('SEXO', user['sexo'] ?? ''),
              _buildField('CIDADE', user['cidade'] ?? ''),
              _buildField('DATA DE NASCIMENTO', user['nascimento'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String value) {
    value = value.toUpperCase();
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
