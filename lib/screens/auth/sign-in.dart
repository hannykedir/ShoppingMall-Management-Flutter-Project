import 'package:flutter/material.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/screens/admin/home.dart';
import 'package:shopping_mall/screens/tenant/home.dart';
import 'package:shopping_mall/utils/db.dart';
import 'package:shopping_mall/utils/helper.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.blue[400],
      //   elevation: 0.0,
      //   title: Text('Sign in to App'),
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person),
      //       label: Text('Register'),
      //       onPressed: () => widget.toggleView(),
      //     ),
      //   ],
      // ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
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
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
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
                obscureText: true,
                validator: (val) => val.isEmpty ? 'Enter a password' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var user = await Helper()
                          .login(User(username: email, password: password));
                      if (user != null) {
                        if (user.isadmin == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminHome()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TenantHome()));
                        }
                      } else {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                        });
                      }
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Home()));
                      // dynamic result = await _auth.signInWithEmailAndPassword(
                      //     email, password);
                      // if (result == null) {
                      // setState(() {
                      //   error = 'Could not sign in with those credentials';
                      // });
                      // }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
