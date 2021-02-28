import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shopping_mall/models/contrat.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;
  final storage = new FlutterSecureStorage();

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "shopping.db"),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE User (
          id INTEGER PRIMARY KEY AUTOINCREMENT,  username TEXT, password TEXT, isadmin INT
        )
        ''');
      await db.execute('''
        CREATE TABLE Tenant (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userid INTEGER,
          fullname TEXT,
          tinnumber TEXT,
          companyname TEXT,
          phonenumber TEXT,
          address TEXT
        )
        ''');
      await db.execute('''
        CREATE TABLE Contrat (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tenantid INTEGER,
          roomnumber TEXT,
          startdate DATETIME,
          enddate DATETIME,
          price DOUBLE
        )
        ''');
      await db.execute(
          "INSERT INTO User ('username', 'password', 'isadmin')"
          "values (?, ?, ?)",
          ["admin", "admin", 1]);
    }, version: 1);
  }

  Future<int> newUser(User newUser) async {
    final db = await database;
    var res = await db.insert("User", newUser.toMap());
    return res;
  }

  getUser(int id) async {
    final db = await database;
    var res = await db.query("User", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? User.fromMap(res.first) : Null;
  }

  Future<List<Contrat>> getUserContrat(int id) async {
    final db = await database;
    var res = await db.query("Contrat", where: "tenantid = ?", whereArgs: [id]);
    print(res);
    // return List<Contrat> list =
    //     res.isNotEmpty ? res.map((c) => Contrat.fromMap(c)).toList() : [];
  }

  Future<Tenant> getTentant(int id) async {
    final db = await database;
    var res = await db.query("Tenant", where: "userid = ?", whereArgs: [id]);
    return res.isNotEmpty ? Tenant.fromMap(res.first) : null;
  }

  Future<User> updateUser(User newUser) async {
    final db = await database;
    var res = await db.update(
        "User", {'username': newUser.username, 'password': newUser.password},
        where: "id = ?", whereArgs: [newUser.id]);
    return newUser;
  }

  deleteUser(int id) async {
    final db = await database;
    db.delete("User", where: "id = ?", whereArgs: [id]);
  }

  Future<User> login(username, password) async {
    final db = await database;
    var res = await db.query("User",
        where: "username = ? AND password = ?",
        whereArgs: [username, password]);
    if (res.isNotEmpty) {
      await storage.write(key: CACHED_TOKEN, value: json.encode(res.first));
    }
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<int> newTenant(Tenant tenant) async {
    final db = await database;
    int newUserId = await newUser(
        User(username: tenant.username, password: tenant.password, isadmin: 0));
    if (newUserId != null) {
      var res = await db.insert("Tenant", {
        " userid": newUserId,
        "fullname": tenant.fullname,
        "tinnumber": tenant.tinnumber,
        "companyname": tenant.companyname,
        "phonenumber": tenant.phonenumber,
        "address": tenant.address,
      });
      return res;
    }
    return null;
  }

  Future<int> newContrat(Contrat contrat) async {
    final db = await database;
    var res = await db.insert('Contrat', contrat.toMap());
    if (res != null) {
      return res;
    }
    return null;
  }

  Future<List<Tenant>> getAllTenants() async {
    final db = await database;
    var res = await db.query("Tenant");
    List<Tenant> list =
        res.isNotEmpty ? res.map((c) => Tenant.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Contrat>> getAllContrats() async {
    final db = await database;
    var res = await db.query("Contrat");
    List<Contrat> list =
        res.isNotEmpty ? res.map((c) => Contrat.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> updateTenant(Tenant tenant) async {
    final db = await database;
    var res = await db.update(
        "Tenant",
        {
          "userid": tenant.userid,
          "fullname": tenant.fullname,
          "tinnumber": tenant.tinnumber,
          "companyname": tenant.companyname,
          "phonenumber": tenant.phonenumber,
          "address": tenant.address,
        },
        where: "id = ?",
        whereArgs: [tenant.id]);
    print(res);
    print(tenant.toMap());
    return res;
  }

  Future deleteTenant(int id) async {
    final db = await database;
    var res = db.delete("Tenant", where: "id = ?", whereArgs: [id]);
    return res;
  }
}
