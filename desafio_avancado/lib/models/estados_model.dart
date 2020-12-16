import 'dart:convert';

class Estados {
  int id;
  String sigla;
  String nome;
  Estados({this.id, this.sigla, this.nome});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sigla': sigla,
      'nome': nome,
    };
  }

  factory Estados.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Estados(
      id: map['id'],
      sigla: map['sigla'],
      nome: map['nome'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Estados.fromJson(String source) =>
      Estados.fromMap(json.decode(source));
}
