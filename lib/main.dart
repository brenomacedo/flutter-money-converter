import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String request = 'https://api.hgbrasil.com/finance?format=json&key=bad275ca'; 

void main() async {

  http.Response response = await http.get(request);
  print(json.decode(response.body));

  runApp(MaterialApp(
    title: "Conversor monetário",
    home: Container(),
  ));
}