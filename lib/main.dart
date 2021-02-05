import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const String request = 'https://api.hgbrasil.com/finance?format=json&key=bad275ca'; 

void main() async {

  print(await getData());

  runApp(MaterialApp(
    title: "Conversor monetário",
    home: Home()
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

              return Container(color: Colors.green);
          }
        },
        future: getData(),
      ),
    );
  }
}

