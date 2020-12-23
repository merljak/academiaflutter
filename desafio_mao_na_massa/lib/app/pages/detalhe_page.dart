import 'package:desafio_mao_na_massa/app/custom_widgets/value_animation.dart';
import 'package:flutter/material.dart';

import 'package:desafio_mao_na_massa/app/custom_widgets/bullet_list.dart';
import 'package:desafio_mao_na_massa/app/models/revenda_model.dart';

class DetalhePage extends StatefulWidget {
  //!//!//!//!//!//!//!//!//!//!//!//!//!//!//!//!
  //!  alias to navigate link to detalhe page  //!
  static String routerName = '/detalhe';

  final RevendaModel revenda;

  //!//!//!//!//!//!//!//!//!//!//!//!//!//!//!//!
  //!     Constructor calling revenda model    //!
  const DetalhePage({
    Key key,
    @required this.revenda,
  }) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState(revenda: revenda);
}

class _DetalhePageState extends State<DetalhePage> {
  final RevendaModel revenda;
  int totProduto = 1;
  double valorFinal;

  _DetalhePageState({@required this.revenda}) : this.valorFinal = revenda.preco;

  var appBar = AppBar(
    elevation: 5,
    title: Text(
      'Selecionar Produtos',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '?',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );

  void addProduct() {
    setState(() {
      totProduto++;
      valorFinal = revenda.preco * totProduto;
    });
  }

  void removeProduct() {
    if (totProduto > 0) {
      setState(() {
        totProduto--;
        valorFinal = revenda.preco * totProduto;
      });
    } else {
      totProduto = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBar,
      body: Column(
        children: <Widget>[
          _buildPurchaseFlow(),
          SizedBox(
            height: 2,
          ),
          _selectedResale(),
          SizedBox(
            height: 0,
          ),
          _purchaseCardDetail(),
          SizedBox(
            height: 210,
          ),
          _checkOutButton(),
        ],
      ),
    );
  }

  Widget _buildPurchaseFlow() {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const BulletList(
            label: 'Comprar',
            enabled: true,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Divider(
                  height: 10,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          const BulletList(
            label: 'Pagamento',
            enabled: false,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Divider(
                  height: 10,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          const BulletList(
            label: 'Confirmação',
            enabled: false,
          ),
        ],
      ),
    );
  }

  Widget _selectedResale() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Color(
                int.parse(
                  'FF${revenda.cor}',
                  radix: 16,
                ),
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                totProduto.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${revenda.nome} - Botijão de Gás de 13 Kg',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ValueAnimation(
            value: valorFinal,
          ),

          // RichText(
          //   text: TextSpan(
          //     style: TextStyle(
          //       color: Colors.black,
          //     ),
          //     children: [
          //       TextSpan(
          //         text: 'R\$',
          //         style: TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       TextSpan(
          //         text:
          //             ' ${valorFinal.toStringAsFixed(2).replaceAll('.', ',')}',
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  _purchaseCardDetail() {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * .9,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 4,
            color: Colors.grey[500],
            offset: Offset(
              5.0,
              6.0,
            ),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                Icons.home,
                size: 40,
                color: Color(
                  int.parse(
                    'FF${revenda.cor}',
                    radix: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${revenda.nome}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text('${revenda.nota} '),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 15,
                        ),
                        Text(' ${revenda.tempoMedio} min'),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.fromLTRB(4, 3, 4, 3),
                    decoration: BoxDecoration(
                      color: Color(
                        int.parse(
                          'FF${revenda.cor}',
                          radix: 16,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '${revenda.tipo}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Aberto ate as ${revenda.horarioFecha}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Botijão de Gás de 13 Kg',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${revenda.nome}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          int.parse(
                            'FF${revenda.cor}',
                            radix: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ValueAnimation(
                      value: valorFinal,
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: 'R\$',
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text:
                    //             ' ${valorFinal.toStringAsFixed(2).replaceAll('.', ',')}',
                    //         style: TextStyle(
                    //           fontSize: 30,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(100),
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
                        child: Center(
                          child: InkWell(
                            onTap: () => this.removeProduct(),
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              //'https://cdn3.iconfinder.com/data/icons/gas-cylinders-1/500/yul777_4_gas_cylinder_forklift_fuel_propane_tank_compressed-128.png'
                              'https://image.flaticon.com/icons/png/128/3828/3828216.png',
                            ),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 29,
                            height: 29,
                            decoration: BoxDecoration(
                              color: Color(
                                int.parse(
                                  'FF${revenda.cor}',
                                  radix: 16,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text(
                                totProduto.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 1,
                              //color: Colors.black,
                              color: Colors.grey[400],
                              offset: Offset(
                                2.0,
                                3.0,
                              ),
                            ),
                          ],
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () => this.addProduct(),
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkOutButton() {
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300,
        height: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[300],
              Colors.blue[700],
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              //color: Colors.black,
              color: Colors.grey[400],
              offset: Offset(
                2.0,
                3.0,
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Ir Para o Pagamento',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
