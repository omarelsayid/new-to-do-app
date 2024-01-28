import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await intialDB();
      return _db!;
    } else {
      return _db!;
    }
  }

  //intializaing the DB
  intialDB() async {
    // this function is used to Get the default databases location.
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.db'); // databasepath/wael.db
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 16, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    log('on upgradE=============');
  }

  _onCreate(Database db, int version) async {
    // Creating table
    await db.execute('''
  CREATE TABLE notes (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    note TEXT NOT NULL,
    title TEXT,
    taskCompleted INTEGER DEFAULT 0
  )
''');
    log('oncreate ========================');
  }

// selecting rows
  selectData(String sql) async {
    // here we use the get db function
    Database? mydb = await db;
    List<Map<String, Object?>> response = await mydb.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    // here we use the get db function
    Database? mydb = await db;
    //Executes a raw SQL INSERT query and returns the last inserted row ID.
    int response = await mydb.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    // here we use the get db function
    Database? mydb = await db;
    //Executes a raw SQL INSERT query and returns the last inserted row ID.
    int response = await mydb.rawUpdate(sql);
    return response;
  }

  DeleteData(String sql) async {
    // here we use the get db function
    Database? mydb = await db;
    //Executes a raw SQL INSERT query and returns the last inserted row ID.
    int response = await mydb.rawDelete(sql);
    return response;
  }
}
