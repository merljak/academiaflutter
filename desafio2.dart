void main() {
  var pessoas = [
    'Rodrigo Rahman|35|Masculino',
    'Jose|56|Masculino',
    'Joaquim|84|Masculino',
    'Rodrigo Rahman|35|Masculino',
    'Maria|88|Feminino',
    'Helena|24|Feminino',
    'Leonardo|5|Masculino',
    'Laura Maria|29|Feminino',
    'Joaquim|72|Masculino',
    'Helena|24|Feminino',
    'Guilherme|15|Masculino',
    'Manuela|85|Feminino',
    'Leonardo|5|Masculino',
    'Helena|24|Feminino',
    'Laura|29|Feminino',
  ];
  // Baseado na lista acima.
  // 1 - Remover os duplicados - Rodrigo 0-3 / - Helena 5-9-13 / - Leonardo 6-12
  // 2 - Me mostre a quantidade de pessoas do sexo Masculino e Feminino
  // 3 - Filtrar e deixar a lista somente com pessoas maiores de 18 anos
  //     e mostre a quantidade de pessoas com mais de 18 anos
  // 4 - Encontre a pessoa mais velha.

  List cleanUpDuplicateList(List list) {
    var cleanList = pessoas.toSet().toList();
    return cleanList;
  }

  List ofAgeList(List list) {
    var ofAgeList = [];
    for (var item in list) {
      var data = item.toString().split('|');
      var age = int.tryParse(data[1]);
      if (age > 18) {
        ofAgeList.add(item);
      }
    }
    return ofAgeList;
  }

  int qtdBySexType(List list, String sexType) {
    var qtd = 0;
    for (var item in list) {
      var data = item.toString().split('|');
      var sex = data[2].toString();
      if (sex == sexType) {
        qtd++;
      }
    }
    return qtd;
  }

  String oldestPersonInList(List list) {
    var person = '';
    var oldestAge = 0;
    for (var item in list) {
      var data = item.toString().split('|');
      var age = int.tryParse(data[1]);
      if (age > oldestAge) {
        oldestAge = age;
        person = item.toString();
      }
    }
    return person;
  }

///////////////////////////////////////////////////
  print('\Lista pessoas antes do tratamento\n');
  print(pessoas);
  var myList = cleanUpDuplicateList(pessoas);
  var myOfAgeList = ofAgeList(myList);
  print('\nQuantidade Masculino: ' +
      qtdBySexType(myOfAgeList, 'Masculino').toString());
  print('\nQuantidade Feminino: ' +
      qtdBySexType(myOfAgeList, 'Feminino').toString());
  print('\nQuantidade Total de pessoas maiores de 18 : ' +
      myOfAgeList.length.toString());
  print('\nPessoa Mais velha: ' + oldestPersonInList(myOfAgeList));
  print('\nLista Maiores de idade nao duplicados\n');
  print(myOfAgeList);
}
