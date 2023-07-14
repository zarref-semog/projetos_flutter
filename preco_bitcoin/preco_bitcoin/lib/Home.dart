import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";

  void _recuperaPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    Map<String, dynamic> resultado = json.decode(response.body);
    setState(
      () {
        _preco = resultado["BRL"]["buy"].toString();
      },
    );
    print("Resultado: " + resultado["BRL"]["buy"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(32),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('imagens/bitcoin.png'),
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child:
                        Text("R\$" + _preco, style: TextStyle(fontSize: 35))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 15)),
                    onPressed: () {},
                    child: Text(
                      "Atualizar",
                    ))
              ],
            ))));
  }
}
