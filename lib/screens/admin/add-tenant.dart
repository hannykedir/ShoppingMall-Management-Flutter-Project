import 'package:flutter/material.dart';
import 'package:shopping_mall/models/tenant.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/utils/helper.dart';

class AddTenant extends StatefulWidget {
  @override
  _AddTenantState createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String success = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _tinnumberController = TextEditingController();
  final TextEditingController _companynameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Add new Tenant'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                controller: _fullnameController,
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
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
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
              TextFormField(
                controller: _tinnumberController,
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
                controller: _companynameController,
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
                controller: _phonenumberController,
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
                controller: _addressController,
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
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[500], width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: showPassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !showPassword,
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
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
                      var newTenant = await Helper().addTenant(Tenant(
                        fullname: _fullnameController.text,
                        username: _usernameController.text,
                        tinnumber: _tinnumberController.text,
                        companyname: _companynameController.text,
                        phonenumber: _phonenumberController.text,
                        address: _addressController.text,
                        password: _passwordController.text,
                      ));
                      if (newTenant != null) {
                        setState(() {
                          success = 'Tenant has added successfully';
                        });
                      } else {
                        setState(() {
                          error = 'Could not add tenant please try again';
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
