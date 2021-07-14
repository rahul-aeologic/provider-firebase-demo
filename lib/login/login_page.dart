import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_project/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

void _setUserEmail(String useremail) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('userEmail', useremail);
}

// ignore: camel_case_types
class _LoginFormState extends State<LoginForm> {
  bool active = false;

  //FlutterOtp otp = FlutterOtp();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode userFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  bool isHidden = true;
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    userFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child:
          // active
          //     ? SignInLoading()
          //     :
          Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Text(
                    'Provider Chat App',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.withOpacity(0.8)),
                  ),
                  Text(
                    'change the way',
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                  ),
                  Container(
                    child: SizedBox(
                      height: 275.0,
                      child: Image.asset(
                        'assets/chaticon.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    focusNode: userFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) {
                      userFocus.unfocus();
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    validator: (value) => !EmailValidator.validate(value, true)
                        ? 'Not a valid email.'
                        : null,
                    onSaved: (value) => username.text = value,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.all(15.0),
                      labelText: 'Enter E-mail',
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    controller: username,
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    onFieldSubmitted: (val) {
                      passwordFocus.unfocus();
                    },
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    obscureText: isHidden,
                    controller: password,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.security,
                        color: Colors.black,
                      ),
                      suffixIcon: InkWell(
                        child: Icon(
                          Icons.visibility,
                          color: Colors.black,
                        ),
                        onTap: password_view,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelText: 'Enter Password',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          print("Forget Password btn clicked");
                        },
                        child: SizedBox(
                          height: 30,
                          child: Text(
                            'Forget Password',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {}
                        if (username.text == '' || password.text == '') {
                          final snackBar = SnackBar(
                            content:
                                Text('Please Enter username & Password..!'),
                            action: SnackBarAction(
                              label: 'warning',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          setState(() => active = true);
                          await _handleSignIn();
                          // setState(() => active = false);
                        }
                      },
                      child: Text(
                        'Log In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'or',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0),
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text('Sign up module under maintenance..!'),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void password_view() {
    setState(() {
      if (isHidden == true) {
        isHidden = false;
      } else {
        isHidden = true;
      }
    });
  }

  _handleSignIn() async {
    try {
      final FirebaseUser user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text,
        password: password.text,
      ))
              .user;

      if (user != null) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage()));
        String email = username.text;
        print(user.email);
        print('Log In Successfully......');
        _setUserEmail(email);
      }
    } catch (e) {
      print(e.toString());
      //setState(() => active = false);
      switch (e.code) {
        case "ERROR_WRONG_PASSWORD":
          {
            final snackBar = SnackBar(
              content: Text('password was Incorrect..!'),
              action: SnackBarAction(
                label: 'error',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
        case "ERROR_USER_NOT_FOUND ":
          {
            final snackBar = SnackBar(
              content: Text('E-mail was Incorrect..!'),
              action: SnackBarAction(
                label: 'error',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
      }
    }
  }

  // void emailVerification() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white.withOpacity(0.9),
  //         title: Text(
  //           'Error',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         content: Text(
  //           "Account Not exist ! \n Or \n Not Verify: Please verify first",
  //           style: TextStyle(fontSize: 18.0, color: Colors.black),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
