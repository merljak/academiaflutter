void main() {
  print('\n\n-------------------- Desafio ------------------------------\n');
  var patients = [
    'Rodrigo Rahman|35|desenvolvedor|SP',
    'Manoel Silva|12|estudante|MG',
    'Joaquim Rahman|18|estudante|SP',
    'Fernando Verne|35|estudante|MG',
    'Gustavo Silva|40|estudante|MG',
    'Sandra Silva|40|estudante|MG',
    'Regina Verne|35|estudante|MG',
    'João Rahman|55|Jornalista|SP',
  ];

  // Baseado no array acima monte um relatório onde mostre
  // Apresente a quantidade de pacientes com mais de 20 anos
  // Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.

  var familyRahman = <String>[];
  var familySilva = <String>[];
  var familyVerne = <String>[];

  for (var patient in patients) {
    var index = (patient.toString().indexOf('|') + 1);
    var age = int.tryParse(patient.substring(index, (index + 2)));
    if (age > 20) {
      if (patient.contains('Rahman')) {
        familyRahman.add(patient);
      } else if (patient.contains('Silva')) {
        familySilva.add(patient);
      } else if (patient.contains('Verne')) {
        familyVerne.add(patient);
      } else {
        // unknow family or unknow age
      }
    }
  }
  var finalFamilyList = familyRahman + familySilva + familyVerne;
  var moreThan20 = finalFamilyList.length;

  print('More than 20 years Old : ' + moreThan20.toString() + '\n');

  print('---------------- Sorted by family ---------------- \n');
  print('\n----- Rahman\'s Family -----');
  for (var family in finalFamilyList) {
    if (family.contains('Rahman')) {
      print(family);
    }
  }
  print('\n----- Silva\'s Family -----');
  for (var family in finalFamilyList) {
    if (family.contains('Silva')) {
      print(family);
    }
  }
  print('\n----- Verne\'s Family -----');
  for (var family in finalFamilyList) {
    if (family.contains('Verne')) {
      print(family);
    }
  }
  print('\n------------------------------------------------');
}
