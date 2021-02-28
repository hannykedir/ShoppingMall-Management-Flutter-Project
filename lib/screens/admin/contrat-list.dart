import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_mall/models/contrat.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/screens/admin/edit-tenant.dart';
import 'package:shopping_mall/utils/helper.dart';

class ContratList extends StatefulWidget {
  @override
  _ContratListState createState() => _ContratListState();
}

class _ContratListState extends State<ContratList> {
  List<Contrat> _contrat = List<Contrat>();
  List<Tenant> _tenants = List<Tenant>();
  String getTentant(int id) {
    var lst = _tenants.where((element) => element.id == id).toList();
    print(_tenants[0].toMap());
    // print(id);
    return lst.length > 0 ? lst[0].fullname : 'unknown';
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
                          title: Text(_contrat[index].roomnumber),
                          subtitle: Text(
                            getTentant(_contrat[index].tenantid),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '${_contrat[index].price} ETB',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'From ${_contrat[index].startdate} - To ${_contrat[index].enddate}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _contrat.length)),
    );
  }
}
