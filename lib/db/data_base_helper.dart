import 'dart:io';

import 'package:dictionary/db/data_base_request.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper._instance();

  DataBaseHelper._instance();

  late final Directory _appDocumentDirectory;
  late final String _pathDB;
  late final Database _dataBase;
  int _version = 1;

  static const String Table_User = 'User';

  Future<void> init() async {
    _appDocumentDirectory =
    await path_provider.getApplicationDocumentsDirectory();

    _pathDB = join(_appDocumentDirectory.path, "clothesstore.db");

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      _dataBase = await databaseFactoryFfi.openDatabase(_pathDB,
          options: OpenDatabaseOptions(
            version: _version,
            onCreate: (db, version) => onCreateTable(db),
            onUpgrade: (db, oldVersion, newVersion) => onUpdateTable(db),
          ));
    } else {
      _dataBase = await openDatabase(_pathDB,
          onUpgrade: (db, oldVersion, newVersion) => onUpdateTable(db),
          onCreate: (db, version) async {
            await onCreateTable(db);
          });
    }
  }

  Future<void> onUpdateTable(Database db) async {
    var tables = await db.rawQuery('SELECT name FROM sqlite_master');
    for (var table in DataBaseRequest.tableList.reversed) {
      if (tables.where((element) => element['name'] == table).isNotEmpty) {
        await db.execute(DataBaseRequest.deleteTable(table));
      }
    }
    for (var element in DataBaseRequest.tableCreateList) {
      db.execute(element);
    }
    await onInitTable(db);
  }

  Future<void> onCreateTable(Database db) async {
    for (var element in DataBaseRequest.tableCreateList) {
      db.execute(element);
    }
    await onInitTable(db);
  }

  Future<void> onInitTable(Database db) async {
    try {
      // db.insert(DataBaseRequest.tableRole, Role(role: 'Администратор').toMap());
      // db.insert(DataBaseRequest.tableRole, Role(role: 'Пользователь').toMap());
      //
      // db.insert(
      //     DataBaseRequest.tableUser,
      //     User(login: 'admin', password: 'admin', idRole: RoleEnum.admin)
      //         .toMap());
    } on DatabaseException catch (e) {
      print(e.result);
    }
  }

  // doLogin(String login, String password) {
  //   getLoginUser(login, password);
  // }

  // Future<User> getLoginUser(String login, String password) async {
  //   var dbClient = await dataBase;
  //   var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
  //       "$C_Login = '$login' AND "
  //       "$C_Password = '$password'");
  //
  //   if (res.length > 0) {
  //     return User.toFromMap(res.first);
  //   }
  //
  //   return User.toFromMap(res.single);
  // }

  // Future<int> saveData(User user) async {
  //   var dbClient = _dataBase;
  //   var res = await dbClient.insert(Table_User, user.toMap());
  //   return res;
  // }

  Future<void> onDropDataBase() async {
    _dataBase.close();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      databaseFactoryFfi.deleteDatabase(_pathDB);
    } else {
      deleteDatabase(_pathDB);
    }
  }
}
