import 'package:dio/dio.dart';
import 'package:desafio_avancado_dart/models/estados_model.dart';

Future<List<Estados>> getEstados() async {
  var dio = Dio();
  var response = await dio
      .get<List>('https://servicodados.ibge.gov.br/api/v1/localidades/estados');
  if (response.statusCode == 200) {
    var estados = response.data.map((e) => Estados.fromMap(e)).toList();
    return estados;
  } else {
    return null;
  }
}
