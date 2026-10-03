import 'package:mysql_client/mysql_client.dart';

class Database {
  static Future<MySQLConnection> connect() async {
    final connection = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: 'girija@2722',
      databaseName: 'gym_project',
    );

    await connection.connect();

    print('MySQL Connected Successfully!');

    return connection;
  }
}