import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent_check_app/General/Constants.dart';
import 'package:parent_check_app/General/General.dart';
import 'package:parent_check_app/controller/UserDAO.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Register.dart';
import 'home.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  TextEditingController _usernme = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _seen = false;
  bool _isButtonDisabled = false;

  var textStyle = TextStyle(
    height: 2,
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  var hintStyle = TextStyle(
    height: 2,
    color: Colors.black,
    fontSize: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black38, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              // margin: EdgeInsets.only,
              child: TextField(
                cursorWidth: 3,
                cursorRadius: Radius.circular(3),
                onSubmitted: (_) {
                  _login();
                },
                controller: _usernme,
                keyboardType: TextInputType.emailAddress,
                style: textStyle,
                decoration: buildInputDecoration(hintText: "Username"),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black38, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            // color: Colors.red,
            margin: EdgeInsets.only(left: 10, right: 10),

            child: Container(
              child: TextField(
                cursorWidth: 3,
                cursorRadius: Radius.circular(3),
                onSubmitted: (_) {
                  _login();
                },
                controller: _password,
                keyboardType: TextInputType.visiblePassword,
                style: textStyle,
                decoration: buildInputDecoration(hintText: "Passoword"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            width: 100,
            child: ElevatedButton(
                onPressed: _login,
                child: Container(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 120, right: 120, top: 20),
            width: 100,
            child: ElevatedButton(
                onPressed: _register,
                child: Container(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    // UserDAO().removeDB();
    // return;
    // var data = await UserDAO.db!.query("Select * from `users` ");
    // print(data);
    // var username = "mahmoud";
    // var pass = "pass";
    // var sql =
    //     "Select * from `users` where  username  = '$username' and  password  = '$pass' ";
    // var data = await UserDAO.db!.rawQuery(sql);
    // var user = User.fromSnapshot(data.first);
    // var sqlUpdate = "UPDATE users set password = 'pass'";
    // print(user);
    // print(UserDAO.db!.isOpen);

    // return;
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (c) => Home()));
    print("login tried");
    if (!_isButtonDisabled) if (_usernme.text == "" || _usernme.text == null) {
      General.infoAlert(
        title: ("Username is Required"),
        text: null,
        type: AlertType.info,
        // width: 100,
      );
    }
    //  else if (_password.text == "" || _password.text == null) {
    //   General.infoAlert(
    //     title: ("Password is Required"),
    //     text: null,
    //     type: AlertType.info,
    //     // width: 100
    //   );
    // }
    // else if ((await Connectivity().checkConnectivity()) ==
    //     ConnectivityResult.none) {
    //   General.showToast(ErrorList.noInternetConnection.myCase,
    //       color: Constants.color_DANGER);
    //   return;
    // }
    else {
      if (mounted)
        setState(() {
          _isButtonDisabled = true;
        });
      try {
        var user = await UserDAO().getUser(_usernme.text, _password.text);
        if (user != null)
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        else {
          General.showToast("Username or password is wrong",
              color: Constants.color_DANGER);
        }
      } on PlatformException catch (e) {
        General.infoAlert(
            text: ("${e.code} ${e.details} ${e.message} ${e.stacktrace}"),
            type: AlertType.error);
      } catch (e) {
        General.infoAlert(text: "Login failed ${e}", type: AlertType.error);
      } finally {
        if (mounted)
          setState(() {
            print(_isButtonDisabled);
            _isButtonDisabled = false;
          });
      }
    }
  }

  void _register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register2()));
  }

  InputDecoration buildInputDecoration(
      {required String hintText, Widget? suffixIcon}) {
    // if (removeLeftPadding) {
    //   contPadd = EdgeInsets.only(
    //       left: -global.getIconSizeMore(),
    //       right: contPdValue,
    //       bottom: contPdValue,
    //       top: contPdValue);
    // }
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.color_INFO),
          borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreen[50]!),
          borderRadius: BorderRadius.circular(8)),
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: suffixIcon ?? SizedBox(),
    );
  }

  // void changeEye() {
  //   setState(() {
  //     _seen = !_seen;
  //     _seen_Icon = General.getEyeIcon(_seen, 16);
  //   });
  // }
}
