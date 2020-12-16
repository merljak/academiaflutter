import 'database/database.dart';

Future<void> importData() async {
  print('INICIANDO O PROCESSO');
  // Conecta com o MySQL
  print('ABRINDO CONEXAO COM O MYSQL DATABSE IBGE');
  var conn = await getConnection();
  // Cria as tabelas
  print('CRIANDO TABELAS NO DATABASE IBGE');
  await createTables(conn);
  // insert Data
  print('INSERINDO DADOS NO DATABASE IBGE');
  await insertData(conn);
  // fecha conexao com o Banco
  await conn.close();
  print('PROCESSO FINALIZADO');
}
