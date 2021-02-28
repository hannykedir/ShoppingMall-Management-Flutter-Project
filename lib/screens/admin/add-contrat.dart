import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_mall/models/contrat.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/utils/helper.dart';

class AddContrat extends StatefulWidget {
  @override
  _AddContratState createState() => _AddContratState();
}

class _AddContratState extends State<AddContrat> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String success = '';
  final TextEditingController _roomnumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool showPassword = false;
  String startDate;
  String endDate;
  int tetantId;

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
        title: Text('Add new Contrat'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Select Tenant',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                items: _tenants.map((Tenant tenant) {
                  return new DropdownMenuItem<String>(
                    value: tenant.id.toString(),
                    child: new Text(tenant.fullname),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    tetantId = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _roomnumberController,
                decoration: InputDecoration(
                  hintText: 'Room numner',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter username' : null,
              ),
              SizedBox(height: 20.0),
              Text('Start Date'),
              Container(
                height: 100,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      startDate = DateFormat('yyyy-MM-dd').format(newDateTime);
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Text('End Date'),
              Container(
                height: 100,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      endDate = DateFormat('yyyy-MM-dd').format(newDateTime);
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Price',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter Price' : null,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var newContrat = await Helper().addContrat(Contrat(
                          tenantid: tetantId,
                          roomnumber: _roomnumberController.text,
                          startdate: startDate,
                          enddate: endDate,
                          price: double.parse(_priceController.text)));
                      if (newContrat != null) {
                        setState(() {
                          success = 'Contrat has added successfully';
                        });
                      } else {
                        setState(() {
                          error = 'Could not add contrat please try again';
                        });
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              Text(
                success,
                style: TextStyle(color: Colors.green, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
