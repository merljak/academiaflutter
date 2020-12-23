import 'package:desafio_mao_na_massa/app/models/revenda_model.dart';
import 'package:desafio_mao_na_massa/app/pages/detalhe_page.dart';
import 'package:desafio_mao_na_massa/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revenda de Gases de Cozinha',
      home: HomePage(),
      routes: {
        DetalhePage.routerName: (_) {
          var revenda = ModalRoute.of(_).settings.arguments as RevendaModel;
          return DetalhePage(
            revenda: revenda,
          );
        }
      },
    );
  }
}
