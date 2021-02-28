import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_mall/models/contrat.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/screens/admin/edit-tenant.dart';
import 'package:shopping_mall/screens/auth/auth.dart';
import 'package:shopping_mall/screens/auth/profile.dart';
import 'package:shopping_mall/utils/helper.dart';

class TenantHome extends StatefulWidget {
  @override
  _TenantHomeState createState() => _TenantHomeState();
}

class _TenantHomeState extends State<TenantHome> {
  List<Contrat> _contrat = List<Contrat>();
  List<Tenant> _tenants = List<Tenant>();
  User _user;
  String getTentant(int id) {
    var lst = _tenants.where((element) => element.id == id).toList();
    print(_tenants[0].toMap());
    // print(id);
    return lst.length > 0 ? lst[0].fullname : 'unknown';
  }

  int getTentantId() {
    var lst = _tenants.where((element) => element.userid == _user.id).toList();
    print(_tenants[0].toMap());
    return lst.length > 0 ? lst[0].id : null;
  }

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
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      Helper().getAllContrat().then((value) => {
            setState(() {
              _contrat.addAll(value);
            })
          });
      Helper().getAllTenant().then((value) => {
            setState(() {
              _tenants.addAll(value);
            })
          });
      Helper().loggedInOrNot.then((value) => {
            setState(() {
              _user = value;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text('Tenant Home'),
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
        body: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Visibility(
                          visible: _contrat[index].tenantid == getTentantId(),
                          child: Card(
                            // clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(_contrat[index].roomnumber),
                                  subtitle: Text(
                                    getTentant(_contrat[index].tenantid),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    '${_contrat[index].price} ETB',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'From ${_contrat[index].startdate} - To ${_contrat[index].enddate}',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                  itemCount: _contrat.length)),
        ));
  }
}
