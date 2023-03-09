import 'package:dictionary/db/data_base_request.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    for (var element in DataBaseRequest.tableCreateList) {
      await database.execute(element);
    }
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('dbTest1.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
      print("..creating a table");
    });
  }

  static Future<int> createItem(String wordName, String wordDescription) async {
    final db = await SQLHelper.db();
    final data = {
      'wordName': wordName,
      'wordDescription': wordDescription,
      'edition': DateTime.now().add(const Duration(hours: 3)).toString(),
      // 'edition': DateTime.now(),
    };
    final id = await db.insert('Word', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace); // дубликаты
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('Word', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('Word', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String wordName, String wordDescription) async {
    final db = await SQLHelper.db();
    final data = {
      'wordName': wordName,
      'wordDescription': wordDescription,
      'edition': DateTime.now().add(const Duration(hours: 3)).toString(),
    };
    final result =
        await db.update('Word', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('Word', where: "id = ?", whereArgs: [id]);
    } catch (error){
      debugPrint("Something went wrong when deleting an item: $error");
    }
  }
}
