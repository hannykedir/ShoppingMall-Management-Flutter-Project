import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/screens/admin/edit-tenant.dart';
import 'package:shopping_mall/utils/helper.dart';

class TenantList extends StatefulWidget {
  @override
  _TenantListState createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  List<Tenant> _tenants = List<Tenant>();

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      Helper().getAllTenant().then((value) => {
            setState(() {
              _tenants.addAll(value);
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
        title: Text('Tenants'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Card(
                    // clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(_tenants[index].companyname),
                          subtitle: Text(
                            _tenants[index].fullname,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '${_tenants[index].tinnumber}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '${_tenants[index].address}, ${_tenants[index].phonenumber}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            FlatButton(
                              textColor: Colors.blue[400],
                              onPressed: () {
                                print(_tenants[index].fullname);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTenant(),
                                    settings: RouteSettings(
                                      arguments: _tenants[index],
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Edit'),
                            ),
                            FlatButton(
                              textColor: Colors.red,
                              onPressed: () async {
                                await Helper().deleteTenant(_tenants[index].id);
                                List<Tenant> newtenants =
                                    await Helper().getAllTenant();
                                setState(() {
                                  _tenants.clear();
                                  _tenants.addAll(newtenants);
                                });
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _tenants.length)),
    );
  }
}
