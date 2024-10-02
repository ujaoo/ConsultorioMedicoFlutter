import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/perfil.dart'; 
import 'package:intl/intl.dart'; 

class AgendamentoPage extends StatefulWidget {
  final Map<String, String> user;

  AgendamentoPage({required this.user});

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  List<Consulta> consultas = [];
  List<Consulta> consultasConcluidas = [];

  @override
  void initState() {
    super.initState();
    consultas.addAll([
      Consulta(
        nome: 'João Silva',
        cpf: '123.456.789-00',
        endereco: 'Rua A, 123',
        dataNascimento: '01/01/1990',
        dataConsulta: DateTime.now().add(Duration(days: 1)),
        horario: '14:00',
      ),
      Consulta(
        nome: 'Maria Souza',
        cpf: '987.654.321-00',
        endereco: 'Rua B, 456',
        dataNascimento: '15/05/1985',
        dataConsulta: DateTime.now().add(Duration(days: 1)),
        horario: '10:30',
      ),
      Consulta(
        nome: 'Ana Oliveira',
        cpf: '456.789.123-00',
        endereco: 'Av. C, 789',
        dataNascimento: '10/08/1982',
        dataConsulta: DateTime.now().add(Duration(days: 3)),
        horario: '08:30',
      ),
      Consulta(
        nome: 'Pedro Santos',
        cpf: '987.654.321-99',
        endereco: 'Rua D, 246',
        dataNascimento: '25/12/1975',
        dataConsulta: DateTime.now().add(Duration(days: 4)),
        horario: '15:45',
      ),
      Consulta(
        nome: 'Luciana Almeida',
        cpf: '321.654.987-11',
        endereco: 'Travessa E, 135',
        dataNascimento: '05/03/1995',
        dataConsulta: DateTime.now().add(Duration(days: 5)),
        horario: '11:00',
      ),
      Consulta(
        nome: 'Marcos Barbosa',
        cpf: '159.357.852-22',
        endereco: 'Praça F, 876',
        dataNascimento: '17/09/1988',
        dataConsulta: DateTime.now().add(Duration(days: 6)),
        horario: '16:20',
      ),
      Consulta(
        nome: 'Julia Ferreira',
        cpf: '753.951.456-33',
        endereco: 'Alameda G, 963',
        dataNascimento: '30/06/1970',
        dataConsulta: DateTime.now().add(Duration(days: 7)),
        horario: '09:15',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    consultas.sort((a, b) {
      int dateComparison = a.dataConsulta.compareTo(b.dataConsulta);
      if (dateComparison != 0) {
        return dateComparison; 
      } else {
        String horaA = a.horario.padLeft(5, '0'); 
        String horaB = b.horario.padLeft(5, '0');
        return horaA.compareTo(horaB); 
      }
    });

    Map<String, List<Consulta>> consultasPorData = {};
    for (var consulta in consultas) {
      String dataFormatada = DateFormat('dd/MM/yyyy').format(consulta.dataConsulta);
      if (!consultasPorData.containsKey(dataFormatada)) {
        consultasPorData[dataFormatada] = [];
      }
      consultasPorData[dataFormatada]!.add(consulta);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patomed',
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'Roboto', 
            fontWeight: FontWeight.bold, 
            fontSize: 24, 
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          SizedBox(width: 20), 
          IconButton(
            icon: Icon(
              Icons.account_circle,
              size: 45, 
              color: Colors.white, 
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilPage(user: widget.user)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _exibirDialog(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Realizar Agendamento'),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _exibirHistoricoConsultas(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Histórico de Consultas'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: consultasPorData.length,
              itemBuilder: (context, index) {
                String data = consultasPorData.keys.elementAt(index);
                List<Consulta> consultasDoDia = consultasPorData[data]!;
                // Ordenar as consultas do dia por horário
                consultasDoDia.sort((a, b) => a.horario.compareTo(b.horario));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.deepPurple,
                            width: 5,
                          ),
                        ),
                      ),
                      child: Text(
                        data,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ...consultasDoDia.map((consulta) => _buildConsultaCard(consulta)).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultaCard(Consulta consulta) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(consulta.horario, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(consulta.nome, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CPF: ${consulta.cpf}'),
                SizedBox(height: 5),
                Text('Endereço: ${consulta.endereco}'),
                SizedBox(height: 5),
                Text('Data de Nascimento: ${consulta.dataNascimento}'),
                SizedBox(height: 5),
                Text('Data da Consulta: ${consulta.dataConsulta.day.toString().padLeft(2, '0')}/${consulta.dataConsulta.month.toString().padLeft(2, '0')}/${consulta.dataConsulta.year} ${consulta.horario}'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _concluirConsulta(consulta);
                      },
                      child: Text('Concluir'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _excluirConsulta(consulta);
                      },
                      child: Text('Excluir'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _exibirDialog(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController cpfController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();
    TextEditingController dataNascimentoController = TextEditingController();
    TextEditingController dataConsultaController = TextEditingController();
    TextEditingController horarioController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agendar Consulta'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome Completo'),
                ),
                TextField(
                  controller: cpfController,
                  decoration: InputDecoration(labelText: 'CPF'),
                ),
                TextField(
                  controller: enderecoController,
                  decoration: InputDecoration(labelText: 'Endereço'),
                ),
                TextField(
                  controller: dataNascimentoController,
                  decoration: InputDecoration(labelText: 'Data de Nascimento'),
                ),
                TextField(
                  controller: horarioController,
                  decoration: InputDecoration(labelText: 'Horário'),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4), HoraInputFormatter()],
                ),
                ListTile(
                  title: Text('Data da Consulta'),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          dataConsultaController.text = picked.toString();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  consultas.add(
                    Consulta(
                      nome: nomeController.text,
                      cpf: cpfController.text,
                      endereco: enderecoController.text,
                      dataNascimento: dataNascimentoController.text,
                      dataConsulta: DateTime.parse(dataConsultaController.text),
                      horario: horarioController.text, 
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirmar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirConsulta(Consulta consulta) {
    setState(() {
      consultas.remove(consulta);
    });
  }

  void _concluirConsulta(Consulta consulta) {
    setState(() {
      consultasConcluidas.add(consulta);
      consultas.remove(consulta);
    });
  }

  void _exibirHistoricoConsultas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoricoConsultasPage(consultasConcluidas),
      ),
    );
  }
}

class Consulta {
  final String nome;
  final String cpf;
  final String endereco;
  final String dataNascimento;
  final DateTime dataConsulta; 
  final String horario; 

  Consulta({
    required this.nome,
    required this.cpf,
    required this.endereco,
    required this.dataNascimento,
    required this.dataConsulta,
    required this.horario, 
  });
}

class HistoricoConsultasPage extends StatelessWidget {
  final List<Consulta> consultasConcluidas;

  HistoricoConsultasPage(this.consultasConcluidas);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico de pacientes',
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'Roboto', 
            fontWeight: FontWeight.bold, 
            fontSize: 24, 
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: consultasConcluidas.length,
        itemBuilder: (context, index) {
          return _buildConsultaCard(consultasConcluidas[index]);
        },
      ),
    );
  }

  Widget _buildConsultaCard(Consulta consulta) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 5, color: Colors.purple)),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${consulta.nome}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('CPF: ${consulta.cpf}'),
            SizedBox(height: 5),
            Text('Endereço: ${consulta.endereco}'),
            SizedBox(height: 5),
            Text('Data de Nascimento: ${consulta.dataNascimento}'),
            SizedBox(height: 5),
            Text('Data da Consulta: ${consulta.dataConsulta.day.toString().padLeft(2, '0')}/${consulta.dataConsulta.month.toString().padLeft(2, '0')}/${consulta.dataConsulta.year} ${consulta.horario}'),
          ],
        ),
      ),
    );
  }
}

class HoraInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    newText = newText.replaceAll(RegExp(r'\D'), '');

    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    if (newText.length > 2) {
      return TextEditingValue(
        text: newText.substring(0, 2) + ':' + newText.substring(2),
        selection: TextSelection.collapsed(offset: newText.length + 1),
      );
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
