import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";
  //Método assíncrono que recupera o valor da APi
  _recuperarPrecoBitcoin () async {
    var url = "https://blockchain.info/ticker";
    http.Response response;
    response = await http.get(Uri.parse(url));
    //Recuperando os dados da requisição utilizando um Map
    Map<String, dynamic> retorno = jsonDecode(response.body);
    //Tenho que utilizar .toString() para converter em String pq o valor vai vir em double
     String buy = retorno["BRL"]["buy"].toString();
      setState(() {
        _preco = "${buy}";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("imagens/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "R\$" + _preco,
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.orange,
                onPressed: _recuperarPrecoBitcoin,
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                      fontSize: 50
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
