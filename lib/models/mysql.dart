import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = "loyaz.net",
      user = "u477970783_aykutik",
      password = "aykuT18092007",
      db = "u477970783_tanlas";
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);

    return await MySqlConnection.connect(settings);
  }
}
