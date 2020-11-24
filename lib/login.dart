import 'package:flutter/material.dart';
import 'package:my_authen_jsonfeed/model/User.dart';
import 'package:my_authen_jsonfeed/services/AuthService.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  User user = User();
  AuthService authService = AuthService();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              _buildForm(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() => Card(
        margin: EdgeInsets.only(top: 90, left: 28, right: 29),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                _logo(),
                SizedBox(
                  height: 30,
                ),
                _UsernameInput(),
                SizedBox(
                  height: 8,
                ),
                _PasswordInput(),
                SizedBox(
                  height: 22,
                ),
                _SubmitBotton(),
                SizedBox(
                  height: 5,
                ),
                _ForgotPassword(),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _logo() => Image.asset(
        ('assets/header_main.jpg'),
        fit: BoxFit.cover,
      );

  Widget _UsernameInput() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'example',
          icon: Icon(Icons.email_outlined),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: _validateEmail,
        onSaved: (String value) {
          user.Username = value;
        },
        onFieldSubmitted: (String value) {
           FocusScope.of(context).requestFocus(passwordFocusNode);
        },
      );

  Widget _PasswordInput() => TextFormField(
        focusNode: passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
          icon: Icon(Icons.phonelink_lock),
        ),
        obscureText: true,
        validator: _validatePassword,
        onSaved: (String value) {
          user.Password = value;
        },
      );

  Widget _SubmitBotton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Colors.deepPurple.shade700,
          onPressed: _submit,
          child: Text(
            'Login'.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _ForgotPassword() => Container(
        child: FlatButton(
          splashColor: Colors.cyan.shade200,
          onPressed: (){},
          padding: EdgeInsets.only(left: 180),
          child: Text(
            'forgot pass...?',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );

  void _submit() {
    if (this._formkey.currentState.validate()) {
      _formkey.currentState.save();

      authService.login(user: user).then((result) {
        if (result) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _showAlertDialog();
        }
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Username or Password is incorrect.'),
            content: Text('please Try Again.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'The Email is Empty';
    }

    if (!isEmail(value)) {
      return 'The Email must be a valid email';
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The password must be as leasr 8 characters';
    }
    return null;
  }
}
