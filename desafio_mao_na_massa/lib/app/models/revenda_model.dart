import 'dart:convert';
//*
//* This class implement the Resale object
//*

class RevendaModel {
  String tipo;
  String nome;
  String cor;
  double nota;
  String tempoMedio;
  bool melhorPreco;
  double preco;
  String horarioFecha;

  RevendaModel({
    this.tipo,
    this.nome,
    this.cor,
    this.nota,
    this.tempoMedio,
    this.melhorPreco,
    this.preco,
    this.horarioFecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'nome': nome,
      'cor': cor,
      'nota': nota,
      'tempoMedio': tempoMedio,
      'melhorPreco': melhorPreco,
      'preco': preco,
      'horarioFecha': horarioFecha,
    };
  }

  factory RevendaModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RevendaModel(
      tipo: map['tipo'],
      nome: map['nome'],
      cor: map['cor'],
      nota: map['nota'],
      tempoMedio: map['tempoMedio'],
      melhorPreco: map['melhorPreco'],
      preco: map['preco'],
      horarioFecha: map['horarioFecha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RevendaModel.fromJson(String source) =>
      RevendaModel.fromMap(json.decode(source));
}
