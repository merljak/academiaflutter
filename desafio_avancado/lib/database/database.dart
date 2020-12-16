import 'package:desafio_avancado_dart/api_ibge/api_estados.dart';
import 'package:desafio_avancado_dart/api_ibge/api_cidades.dart';
import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> getConnection() async {
  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'ibge');
  return await MySqlConnection.connect(settings);
}

// VOID CREATE TABLES
void createTables(MySqlConnection conn) async {
// CREATE TABLE ESTADOS
  await conn.query('''
      CREATE TABLE IF NOT EXISTS estados (
      id int primary key not null, 
      estado varchar(100) not null, 
      sigla varchar(2) not null
      );
    ''');
  print("TABLE 'ESTADOS' CREATE SUCCESS");

  // CREATE TABLE CIDADES
  await conn.query('''
    CREATE TABLE IF NOT EXISTS cidades (
    id int primary key not null,
    cidade varchar(100) not null,
    estado_id int not null,
    foreign key (estado_id) references estados(id)
    )AUTO_INCREMENT = 1;
    ''');
  print("TABLE 'CIDADES' CREATE SUCCESS");
}

Future insertData(MySqlConnection conn) async {
  var estados = await getEstados();
  await Future.forEach(estados, (e) async {
    await conn.query('INSERT INTO estados (id, estado, sigla) VALUES (?, ?, ?)',
        [e.id, e.nome, e.sigla]);
    print('Adicionado o Estado ${e.nome}\n');
    await insertDataCidades(conn, e.id);
    print('\nCidades do estado ${e.nome} foram adicionadas\n');
  });
}

void insertDataCidades(MySqlConnection conn, int estado_id) async {
  var cidades = await getCidadesByEstadoId(estado_id);
  await Future.forEach(cidades, (c) async {
    await conn.query(
        'INSERT INTO cidades (id, cidade, estado_id) VALUES (?, ?, ?)',
        [c.id, c.nome, estado_id]);
    print('Adicionado Cidade ${c.nome}');
  });
}
