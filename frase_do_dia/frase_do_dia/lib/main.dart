import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _frases = [
    "Comece onde você está, use o que você tem e faça o que você pode.",
    "Tudo o que um sonho precisa para ser realizado é alguém que acredite que ele possa ser realizado.",
    "Devíamos ser ensinados a não esperar por inspiração para começar algo. Ação sempre gera inspiração. Inspiração raramente gera ação.",
    "Não importa que você vá devagar, contanto que você não pare.",
    "A inspiração existe, porém temos que encontrá-la trabalhando.",
    "Coragem é saber o que não temer.",
    "Conhecer a si mesmo é o começo de toda sabedoria.",
    "Descubra quem é você, e seja essa pessoa. A sua alma foi colocada nesse mundo para ser isso, então viva essa verdade e todo resto virá.",
    "Acredite em milagres, mas não dependa deles.",
    "Não é a carga que o derruba, mas a maneira como você a carrega.",
    "Não existe nada de completamente errado no mundo, mesmo um relógio parado, consegue estar certo duas vezes por dia.",
    "A vida é 10% o que acontece a você e 90% como você reage a isso.",
  ];

  var _fraseGerada = "Clique abaixo para gerar uma frase.";

  void _gerarFrase() {
    var numeroFrase = Random().nextInt(_frases.length);
    setState(() {
      _fraseGerada = _frases[numeroFrase];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frase do Dia"),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Container(
        //width: double.infinity,
        padding: EdgeInsets.all(16),
        /*
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.amber),
        ),
        */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("recursos/logo.png"),
            Text(
              _fraseGerada,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: _gerarFrase,
              child: const Text("Nova Frase",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      )),
    );
  }
}
