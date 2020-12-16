import 'dart:convert';

class Cidades {
  int id;
  String nome;
  Cidades({this.id, this.nome});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory Cidades.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Cidades(
      id: map['id'],
      nome: map['nome'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Cidades.fromJson(String source) =>
      Cidades.fromMap(json.decode(source));
}
