import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:text_scroll/text_scroll.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(width: 2, color: Colors.green))))));
}

class Usuario {
  var nome;
  var senha;
  var nomeCompleto;
  var fone;
  var email;

  Usuario(nome, senha) {
    this.nome = nome;
    this.senha = senha;
  }

  validarUsuario() async {
    final url =
        Uri.parse('http://177.66.12.138:9091/smart/WsAutenticar.rule?sys=SIT');
    final resposta = await http.post(url,
        body: json.encode({'login': nome, 'senha': senha}));
    Map<String, dynamic> retorno = json.decode(resposta.body);
    String status = retorno['status'];
    if (status == '200') {
      nomeCompleto = retorno['name'];
      email = retorno['email'];
      fone = retorno['phone'];
      return true;
    } else {
      return false;
    }
  }

  void setNome(nome) {
    if (!nome.isNull) {
      this.nome = nome;
    }
  }

  String getNome() {
    return nome;
  }

  void setSenha(senha) {
    if (!senha.isNull) {
      this.senha = senha;
    }
  }

  String getSenha() {
    return senha;
  }

  getNomeCompleto() {
    return nomeCompleto;
  }

  getEmail() {
    return email;
  }

  getFone() {
    return fone;
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controladorNome = TextEditingController();
  final _controladorSenha = TextEditingController();
  String texto = "";
  bool textoErro = false;

  @override
  Widget build(BuildContext context) {
    _usuarioLogin() {
      return TextField(
          controller: _controladorNome,
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Nome",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
              )));
    }

    _usuarioSenha() {
      return TextField(
          controller: _controladorSenha,
          obscureText: true,
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Senha",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32))));
    }

    _botaoLogar() {
      return Material(
          elevation: 5,
          color: Colors.green,
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Text("Entrar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              onPressed: () async {
                try {
                  Usuario usuario = new Usuario(
                      _controladorNome.text, _controladorSenha.text);
                  bool resultado = await usuario.validarUsuario();
                  if (resultado) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                usuario.getNomeCompleto(),
                                usuario.getEmail(),
                                usuario.getFone())));
                  } else {
                    setState(() {
                      textoErro = true;
                      texto = "Login ou senha inválidos. Tente novamente.";
                    });
                  }
                } catch (e) {
                  setState(
                    () {
                      texto = "Erro de validação. Tente novamente mais tarde.";
                    },
                  );
                }
              }));
    }

    _botaoCadastrar() {
      return TextButton(
        child: Text("Cadastrar",
            style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onPressed: () {},
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(36),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  visible: textoErro,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.0),
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(texto,
                            style: TextStyle(color: Colors.red, fontSize: 14))),
                  )),
              SizedBox(height: 20),
              _usuarioLogin(),
              SizedBox(height: 20),
              _usuarioSenha(),
              SizedBox(height: 60),
              _botaoLogar(),
              SizedBox(height: 10),
              _botaoCadastrar()
            ]),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final nomeCompleto;
  final email;
  final fone;

  HomePage(this.nomeCompleto, this.email, this.fone);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _mostrar = true;

  @override
  Widget build(BuildContext context) {
    _listaEstatica() {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Material(
                borderRadius: BorderRadius.circular(100),
                elevation: 5,
                color: Colors.green,
                child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white)),
              ),
            ),
            MaterialButton(
                height: 70,
                onPressed: () {},
                child: Container(
                    alignment: Alignment.centerLeft, child: Text("Item 1"))),
            Divider(),
            MaterialButton(
                height: 70,
                onPressed: () {},
                child: Container(
                    alignment: Alignment.centerLeft, child: Text("Item 2"))),
            Divider(),
            MaterialButton(
                height: 70,
                onPressed: () {},
                child: Container(
                    alignment: Alignment.centerLeft, child: Text("Item 3"))),
            Divider()
          ],
        ),
      );
    }

    _listaDinamica() {
      return Visibility(
          visible: _mostrar,
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    height: 70,
                    onPressed: () {},
                    child: Container(
                      child: Text("Item 4"),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Divider(),
                  MaterialButton(
                    height: 70,
                    onPressed: () {},
                    child: Container(
                      child: Text("Item 5"),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Divider(),
                  MaterialButton(
                    height: 70,
                    onPressed: () {},
                    child: Container(
                      child: Text("Item 6"),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Divider()
                ],
              )));
    }

    _botaoSair() {
      return MaterialButton(
          height: 70,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Container(
              alignment: Alignment.bottomCenter,
              child: Text("Sair", style: TextStyle(color: Colors.red))));
    }

    return Scaffold(
        drawer: Drawer(
            child: Expanded(
          child: Column(
              children: [_listaEstatica(), _listaDinamica(), _botaoSair()]),
        )),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
              backgroundColor: Colors.green,
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 40),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              }),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 60,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                    widget.nomeCompleto,
                                    widget.email,
                                    widget.fone)));
                      },
                      child: Row(children: [
                        Container(
                            width: 200,
                            padding: EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextScroll(" ${widget.nomeCompleto}    ",
                                    textAlign: TextAlign.right,
                                    mode: TextScrollMode.endless,
                                    velocity: Velocity(
                                        pixelsPerSecond: Offset(30, 0)),
                                    delayBefore: Duration(seconds: 3),
                                    pauseBetween: Duration(seconds: 3),
                                    fadedBorder: true,
                                    fadedBorderWidth: 0.02,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text("Outras Informações",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white))
                              ],
                            )),
                        CircleAvatar(
                            backgroundImage: AssetImage('recursos/perfil.jpg'),
                            radius: 25)
                      ]),
                    ),
                  ),
                )
              ]),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.center,
              child: Text("Conteúdo", style: TextStyle(fontSize: 30)),
            )));
  }
}

class ProfilePage extends StatelessWidget {
  final nomeCompleto;
  final email;
  final fone;

  ProfilePage(this.nomeCompleto, this.email, this.fone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Text("Página do Perfil"),
            backgroundColor: Colors.green,
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                alignment: Alignment.center,
                child: Column(children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.green,
                    child: CircleAvatar(
                        backgroundImage: AssetImage('recursos/perfil.jpg'),
                        radius: 50),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Informações Pessoais',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Text('Nome',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('${nomeCompleto}',
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 40),
                            Text('Email',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('${email}', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 40),
                            Text('Contato',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('${fone}', style: TextStyle(fontSize: 18))
                          ]))
                ]))));
  }
}
