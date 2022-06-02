import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controlerNome = TextEditingController();
  TextEditingController _controlerIdade = TextEditingController();
  TextEditingController _controlerSalario = TextEditingController();
  bool inicio = true;

  _gravar() async {
    var preferencias = await SharedPreferences.getInstance();
    await preferencias.setString("nome", _controlerNome.text);
    await preferencias.setInt("idade", int.parse(_controlerIdade.text));
    await preferencias.setDouble("salario", double.parse(_controlerSalario.text));
  }

  _atualizar() async {
    var preferencias = await SharedPreferences.getInstance();
    setState(() {
      if (preferencias.getString("nome") == null) {
        _controlerNome.text = "";
      } else {
        _controlerNome.text = preferencias.getString("nome");
      }
      if (preferencias.getInt("idade") == null) {
        _controlerIdade.text = "";
      } else {
        _controlerIdade.text = preferencias.getInt("idade").toString();
      }
      if (preferencias.getDouble("salario") == null) {
        _controlerSalario.text = "";
      } else {
        _controlerSalario.text = preferencias.getDouble("salario").toString();
      }
    });
  }

  _apagar() async {
    var preferencias = await SharedPreferences.getInstance();
    preferencias.remove("nome");
    preferencias.remove("idade");
    preferencias.remove("salario");
    setState(() {
      _controlerNome.text = "";
      _controlerIdade.text = "";
      _controlerSalario.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    // If abaixo criado para que se houver dados eles apareçam na tela quando o app é carregado
    if (inicio) {
      _atualizar();
      inicio = false;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Informações Usuário"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Icon(Icons.face, color: Colors.redAccent, size: 100),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Digite o Nome:"),
                  controller: _controlerNome,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Digite a idade:"),
                  controller: _controlerIdade,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Digite o Salário:"),
                  controller: _controlerSalario,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 80.0, bottom: 10.0)),
                    RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Gravar",
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: _gravar),
                    RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Atualizar",
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: _atualizar),
                    RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Apagar",
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: _apagar)
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
