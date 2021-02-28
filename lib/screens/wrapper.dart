import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/screens/admin/home.dart';
import 'package:shopping_mall/screens/auth/auth.dart';
import 'package:shopping_mall/screens/auth/sign-in.dart';
import 'package:shopping_mall/screens/tenant/home.dart';
import 'package:shopping_mall/utils/constants.dart';
import 'package:shopping_mall/utils/helper.dart';

class Wraper extends StatelessWidget {
  // final storage = FlutterSecureStorage();
  // Future<String> get loggedInOrNot async {
  //   var token = await storage.read(key: CACHED_TOKEN);
  //   if (token == null) return "";
  //   return token;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Helper().loggedInOrNot,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            User userData = snapshot.data;
            if (userData.isadmin == 1) {
              return AdminHome();
            } else {
              return TenantHome();
            }
          } else {
            return SignIn();
          }
        });
  }
}
