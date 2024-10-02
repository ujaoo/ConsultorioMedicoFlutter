import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/agendamento.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final List<Map<String, String>> _users = [
  {
    'username': 'joao',
    'password': '123',
    'especializacao': 'clinico geral',
    'telefone': '46-991259468',
    'sexo': 'Masculino',
    'cidade': 'Pato Branco',
    'nascimento': '11/03/1998'
  },
  {
    'username': 'igor',
    'password': '123',
    'especializacao': 'neurologia',
    'telefone': '46-991329354',
    'sexo': 'Masculino',
    'cidade': 'Pato Branco',
    'nascimento': '27/11/1985'
  },
  {
    'username': 'lucas',
    'password': '123',
    'especializacao': 'oftalmologista',
    'telefone': '46-999275234',
    'sexo': 'Masculino',
    'cidade': 'Pato Branco',
    'nascimento': '03/05/1972'
  },
 /* {
    'username': '',
    'password': '',
    'especializacao': 'clinico geral',
    'telefone': '46-991259468',
    'sexo': 'Masculino',
    'cidade': 'Pato Branco',
    'nascimento': '11/03/1998'
  },*/
];

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Map<String, String>? _authenticatedUser;

  void _login() {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;
    bool isUserValid = false;

    for (var user in _users) {
      if (user['username'] == enteredUsername &&
          user['password'] == enteredPassword) {
        isUserValid = true;
        _authenticatedUser = user;
        break;
      }
    }

    if (isUserValid && _authenticatedUser != null) {
      print('Login bem-sucedido!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AgendamentoPage(user: _authenticatedUser!),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Credenciais inválidas'),
            content: Text('Por favor, verifique seu nome de usuário e senha.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PATOMED',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Espaçamento
              Text(
                'Acesse nosso sistema',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.0, // Tamanho menor
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30), // Espaçamento maior
              TextField(
                controller: _usernameController,
                style: TextStyle(color: Colors.purple),
                decoration: InputDecoration(
                  labelText: 'Nome de usuário',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.purple),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
