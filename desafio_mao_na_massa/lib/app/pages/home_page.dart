import 'dart:ui';
import 'package:desafio_mao_na_massa/app/custom_widgets/tag_preco.dart';
import 'package:desafio_mao_na_massa/app/models/revenda_model.dart';
import 'package:desafio_mao_na_massa/app/pages/detalhe_page.dart';
import 'package:desafio_mao_na_massa/app/repositories/revendas_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filter = [
    'Melhor Avaliacao',
    'Mais Rapido',
    'Mais Barato'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: false,
        elevation: 5,
        title: Text(
          'Escolha uma Revenda',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton(
              icon: Icon(
                Icons.swap_vert,
                size: 30,
              ),
              itemBuilder: (_) {
                return filter.map((f) {
                  return PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          f,
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                          onChanged: (bool value) {},
                          value: false,
                        )
                      ],
                    ),
                  );
                }).toList();
              }),
          PopupMenuButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '?',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: Text(
                      'Suporte',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Termos de Servico',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ];
              }),
          SizedBox(width: 10),
        ],
      ),
      /////////////////////////////////////////////////////////////////////////////////////////////
      body: Column(children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Botijões de Gas de 13 KG em:',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      'Av Paulista, 1001',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Paulista, São Paulo, SP',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.place_sharp,
                    color: Colors.blue,
                    size: 30,
                  ),
                  Text(
                    'Mudar',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // builder => create component list dynamically mandatory return
        Expanded(
          child: FutureBuilder<List<RevendaModel>>(
            future: RevendasRepository().buscarRevendas(),
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  var datarevenda = snapshot.data;
                  return ListView.builder(
                      itemCount: datarevenda.length,
                      itemBuilder: (_, index) {
                        return _buildRevendaData(datarevenda[index]);
                      });
                  break;
              }
            },
          ),
        )
      ]),
    );
  }

  Widget _buildRevendaData(RevendaModel revenda) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        DetalhePage.routerName,
        arguments: revenda, // sending the parameters for detail page
      ),
      child: Container(
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(int.parse(
                  'FF${revenda.cor}',
                  radix: 16,
                )),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: RotatedBox(
                quarterTurns: -1,
                child: Center(
                  child: Text(
                    revenda.tipo,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.grey[400],
                      offset: Offset(
                        2.0,
                        3.0,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              revenda.nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // verify the boolean to showing the orange tag best price
                          //revenda.melhorPreco ? TagPreco() : Container(),
                          Visibility(
                            visible: revenda.melhorPreco,
                            child: TagPreco(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Nota',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    revenda.nota.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[600],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Tempo Medio',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: revenda.tempoMedio,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' min',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Preco',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'R\$ ${revenda.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
