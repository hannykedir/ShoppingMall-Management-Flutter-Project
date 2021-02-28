import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shopping_mall/models/contrat.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/utils/db.dart';

import 'constants.dart';

class Helper {
  final storage = FlutterSecureStorage();
  Future<User> get loggedInOrNot async {
    var userData = await storage.read(key: CACHED_TOKEN);
    return userData == null ? null : User.fromMap(jsonDecode(userData));
  }

  writeToStorage(value) async {
    await storage.write(
        key: CACHED_TOKEN, value: json.encode(User.toJson(value)));
  }

  Future<User> login(User user) async {
    User res = await DBProvider.db.login(user.username, user.password);
    if (res != null) {
      writeToStorage(res);
      return res;
    }
    return null;
  }

  logout() async {
    await storage.deleteAll();
  }

  Future<User> updateUser(User user) async {
    User res = await DBProvider.db.updateUser(user);
    if (res != null) {
      writeToStorage(res);
      return res;
    }
    return null;
  }

  Future addTenant(Tenant tenant) async {
    var res = await DBProvider.db.newTenant(tenant);
    if (res != null) {
      return res;
    }
    return null;
  }

  Future addContrat(Contrat contrat) async {
    var res = await DBProvider.db.newContrat(contrat);
    if (res != null) {
      return res;
    }
    return null;
  }

  Future<List<Tenant>> getAllTenant() async {
    return DBProvider.db.getAllTenants();
  }

  Future<List<Contrat>> getAllContrat() async {
    return DBProvider.db.getAllContrats();
  }

  Future editTenant(Tenant tenant) async {
    var res = await DBProvider.db.updateTenant(tenant);
    if (res != null) {
      return res;
    }
    return null;
  }

  Future deleteTenant(int id) async {
    var res = await DBProvider.db.deleteTenant(id);
    return res;
  }

  Future<String> getTenant(int id) async {
    var res = await DBProvider.db.getTentant(id);
    return res.fullname;
  }

  Future<Contrat> getUserContrat() async {
    // User user = await loggedInOrNot;
    // Tenant tenant = await DBProvider.db.getTentant(user.id);
    // var res = await DBProvider.db.getUserContrat(tenant.id);
    // return res;
  }
}
