import 'package:flutter/material.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/screens/admin/add-contrat.dart';
import 'package:shopping_mall/screens/admin/add-tenant.dart';
import 'package:shopping_mall/screens/admin/contrat-list.dart';
import 'package:shopping_mall/screens/admin/tenant-list.dart';
import 'package:shopping_mall/screens/auth/auth.dart';
import 'package:shopping_mall/screens/auth/profile.dart';
import 'package:shopping_mall/utils/helper.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        Helper().logout();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth()));
        break;
      case 'Edit Profile':
        // User userData = await Helper().loggedInOrNot;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: await Helper().loggedInOrNot,
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Admin Dashboard'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Edit Profile'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Add Tenant',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTenant()));
                        })),
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Add Contrat',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddContrat()));
                        })),
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Tenants',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TenantList()));
                        })),
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Contrats',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContratList()));
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
