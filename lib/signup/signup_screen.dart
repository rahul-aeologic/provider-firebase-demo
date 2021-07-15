import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_project/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

void _setUserEmail(String useremail) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('userEmail', useremail);
}

// ignore: camel_case_types
class _SignupScreenState extends State<SignupScreen> {
  bool active = false;

  //FlutterOtp otp = FlutterOtp();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FocusNode userFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();
  bool isHidden = true;
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    userFocus.dispose();
    passwordFocus.dispose();
    nameFocus.dispose();
    confirmPassFocus.dispose();
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
      child: active
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
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
                            height: 150.0,
                            child: Image.asset(
                              'assets/chaticon.png',
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          focusNode: nameFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            nameFocus.unfocus();
                            FocusScope.of(context).requestFocus(userFocus);
                          },
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.all(15.0),
                            labelText: 'Name',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                          controller: nameController,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          focusNode: userFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            userFocus.unfocus();
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                          validator: (value) =>
                              !EmailValidator.validate(value, true)
                                  ? 'Not a valid email.'
                                  : null,
                          onSaved: (value) => usernameController.text = value,
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
                          controller: usernameController,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          onFieldSubmitted: (val) {
                            passwordFocus.unfocus();
                            FocusScope.of(context)
                                .requestFocus(confirmPassFocus);
                          },
                          focusNode: passwordFocus,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          obscureText: isHidden,
                          controller: passwordController,
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
                              onTap: _passwordView,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            labelText: 'Enter Password',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          onFieldSubmitted: (val) {
                            confirmPassFocus.unfocus();
                          },
                          focusNode: confirmPassFocus,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          obscureText: true,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.security,
                              color: Colors.black,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 40),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.blue,
                          child: MaterialButton(
                            padding:
                                EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {}
                              if (usernameController.text == '' ||
                                  passwordController.text == '' ||
                                  nameController.text == '' ||
                                  confirmPasswordController.text == '') {
                                final snackBar = SnackBar(
                                  content: Text('Required all field..!'),
                                  action: SnackBarAction(
                                    label: 'warning',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                setState(() => active = true);
                                await _handleSignUp();
                                setState(() => active = false);
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Password Not Matched..!'),
                                  action: SnackBarAction(
                                    label: 'warning',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
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

  void _passwordView() {
    setState(() {
      if (isHidden == true) {
        isHidden = false;
      } else {
        isHidden = true;
      }
    });
  }

  _handleSignUp() async {
    try {
      final FirebaseUser user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      ))
              .user;

      if (user != null) {
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
        String email = usernameController.text;
        print(user.email);
        print('User Registered Successfully......');
        _setUserEmail(email);
      }
    } catch (e) {
      print(e.toString());
      setState(() => active = false);
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          {
            final snackBar = SnackBar(
              content: Text('E-mail is already in use..!'),
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
}
