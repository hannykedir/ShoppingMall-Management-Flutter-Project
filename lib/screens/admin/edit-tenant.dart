import 'package:flutter/material.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/utils/helper.dart';

class EditTenant extends StatefulWidget {
  @override
  _EditTenantState createState() => _EditTenantState();
}

class _EditTenantState extends State<EditTenant> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String success = '';
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _tinnumberController = TextEditingController();
  final TextEditingController _companynameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final Tenant tenant = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Edit Tenant'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                controller: _fullnameController
                  ..text = tenant != null ? tenant.fullname : '',
                decoration: InputDecoration(
                  hintText: 'Fullname',
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
                validator: (val) => val.isEmpty ? 'Enter name' : null,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _tinnumberController
                  ..text = tenant != null ? tenant.tinnumber : '',
                decoration: InputDecoration(
                  hintText: 'Tin number',
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
                validator: (val) => val.isEmpty ? 'Enter tin number' : null,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _companynameController
                  ..text = tenant != null ? tenant.companyname : '',
                decoration: InputDecoration(
                  hintText: 'Company name',
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
                validator: (val) => val.isEmpty ? 'Enter company name' : null,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _phonenumberController
                  ..text = tenant != null ? tenant.phonenumber : '',
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone number',
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
                validator: (val) => val.isEmpty ? 'Enter Phone number' : null,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _addressController
                  ..text = tenant != null ? tenant.address : '',
                decoration: InputDecoration(
                  hintText: 'Address',
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
                validator: (val) => val.isEmpty ? 'Enter address' : null,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Save changes',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var newTenant = await Helper().editTenant(Tenant(
                          fullname: _fullnameController.text,
                          tinnumber: _tinnumberController.text,
                          companyname: _companynameController.text,
                          phonenumber: _phonenumberController.text,
                          address: _addressController.text));
                      if (newTenant != 0) {
                        setState(() {
                          success = 'Tenant has updated successfully';
                        });
                      } else {
                        setState(() {
                          error = 'Could not update tenant please try again';
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
