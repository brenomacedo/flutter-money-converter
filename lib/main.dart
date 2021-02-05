import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const String request = 'https://api.hgbrasil.com/finance?format=json&key=bad275ca'; 

void main() async {

  print(await getData());

  runApp(MaterialApp(
    title: "Conversor monetário",
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber)
      )
    ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coversor monetário"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando dados!",
                style: TextStyle(color: Colors.amber, fontSize: 25.0), textAlign: TextAlign.center)
              );
            default:
              if(snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar os dados!",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0), textAlign: TextAlign.center)
                );
              }

              dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
              euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Icon(Icons.monetization_on, size: 150, color: Colors.amber),
                    buildTextField("Reais", "R\$"),
                    Divider(),
                    buildTextField("Dolares", "US\$"),
                    Divider(),
                    buildTextField("Euros", "€")
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
                padding: EdgeInsets.all(10.0),
              );
          }
        },
        future: getData(),
      ),
    );
  }
}

Widget buildTextField(String label, String prefix) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix
    ),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
  );
}