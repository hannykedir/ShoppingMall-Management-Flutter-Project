import 'package:flutter/material.dart';
import 'package:shopping_mall/models/user.dart';
import 'package:shopping_mall/utils/helper.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String success = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    // text field state

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Edit your profile'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                controller: _usernameController
                  ..text = user == null ? '' : user.username,
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
                  // setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController
                  ..text = user == null ? '' : user.password,
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
                onChanged: (val) {
                  // setState(() => password = val);
                },
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
                      User newUser = await Helper().updateUser(User(
                          id: user.id,
                          username: _usernameController.text,
                          password: _passwordController.text,
                          isadmin: user.isadmin));
                      if (newUser != null) {
                        Navigator.pop(context);
                        setState(() {
                          success = 'Your profile has updated successfully';
                        });
                      } else {
                        setState(() {
                          error = 'Could not update profile please try again';
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
