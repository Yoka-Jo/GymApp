import 'package:flutter/material.dart';
import 'package:test_app/shared/components/background_color.dart';
import 'package:test_app/shared/constants/constants.dart';
import 'package:test_app/shared/network/local/cache_helper.dart';
import '../../shared/components/TextField_checkBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/home_screen.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  // This is because i'm using switch case to return the right validation text.
  int _validateNameError = 0;
  int _validateEmailError = 1;
  int _validateWeightError = 2;
  int _validateHeightError = 3;
  int _validatePassowrdError = 4;

  bool isLogIN = true;

  bool _isLoading = false;

  String _onSavedName = '';
  String _onSavedEmail = '';
  String _onSavedPassword = '';
  int _onSavedWeight = 0;
  int _onSavedHeight = 0;

  final submitKey = GlobalKey<FormState>();

  void trySubmit() async {
    final isValid = submitKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      submitKey.currentState.save();
      try {
        setState(() {
          _isLoading = true;
        });
        if (isLogIN) {
          final userData = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: _onSavedEmail.trim(),
                  password: _onSavedPassword.trim());
          uId = userData.user.uid;
          CacheHelper.saveData(key: "uId", value: userData.user.uid)
              .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName,
                    (route) {
                      return false;
                    },
                  ));
        } else {
          final userData = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _onSavedEmail.trim(),
                  password: _onSavedPassword.trim());
          uId = userData.user.uid;
          CacheHelper.saveData(key: "uId", value: userData.user.uid);

          await FirebaseFirestore.instance
              .collection('emails')
              .doc(userData.user.uid)
              .set({
            'userName': _onSavedName.trim(),
            'weight': _onSavedWeight,
            'height': _onSavedHeight,
            'userId': FirebaseAuth.instance.currentUser.uid,
          });

          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) {
              return false;
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            'Check your password and Email again',
            style: TextStyle(color: Color(0xff2D2940)),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundColor(
      onBackgroundWidget: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(children: [
              Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Color(0xff232035),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      color: Color(0xff2D2940),
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 80.0,
                  left: 130.0,
                  child: Text(
                    "Logo",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              Stack(children: [
                Container(
                  margin: EdgeInsets.only(left: 18, top: 150),
                  height: isLogIN ? 340 : 500,
                  width: 320,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff232038),
                          blurRadius: 1.0,
                          spreadRadius: 2.5,
                          offset: Offset(
                              0.0, 5.0), // shadow direction: bottom right
                        )
                      ], // shadow direction: bottom right
                      color: Color(0xff2F2C41),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LogoText(
                            textName: 'LOGIN',
                            onTap: () {
                              setState(() {
                                isLogIN = true;
                              });
                            },
                          ),
                          LogoText(
                            textName: 'SIGN UP',
                            onTap: () {
                              setState(() {
                                isLogIN = false;
                              });
                            },
                          ),
                        ],
                      ),
                      Stack(children: [
                        Divider(
                          endIndent: 25,
                          indent: 25,
                          color: Colors.white30,
                          thickness: .5,
                        ),
                        if (isLogIN)
                          Divider(
                            endIndent: 230,
                            indent: 58,
                            color: Colors.blue,
                            thickness: 2,
                          ),
                        if (!isLogIN)
                          Divider(
                            endIndent: 70,
                            indent: 218,
                            color: Colors.blue,
                            thickness: 2,
                          ),
                      ]),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: submitKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              if (!isLogIN)
                                SizedBox(
                                  height: 30.0,
                                ),
                              if (!isLogIN)
                                TextForm(
                                  show: 1,
                                  onSaved: (value) {
                                    setState(() {
                                      _onSavedName = value;
                                    });
                                  },
                                  key: ValueKey('name'),
                                  labelText: 'Full Name',
                                  hintText: 'Enter Your Name',
                                  icon: Icons.person,
                                  showIcon: false,
                                  textInputType: TextInputType.text,
                                  leftPadding: 15,
                                  rightPadding: 15,
                                  errorValidator: _validateNameError,
                                ),
                              if (!isLogIN)
                                SizedBox(
                                  height: 25,
                                ),
                              if (isLogIN)
                                SizedBox(
                                  height: 25.0,
                                ),
                              TextForm(
                                //onSubmitted: null,
                                show: 1,
                                onSaved: (value) {
                                  setState(() {
                                    _onSavedEmail = value;
                                  });
                                },
                                key: ValueKey('email'),
                                labelText: 'Email',
                                hintText: 'Enter Your Email',
                                icon: Icons.email_outlined,
                                showIcon: false,
                                textInputType: TextInputType.emailAddress,
                                leftPadding: 15,
                                rightPadding: 15,
                                errorValidator: _validateEmailError,
                              ),
                              if (!isLogIN)
                                SizedBox(
                                  height: 25,
                                ),
                              if (!isLogIN)
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextForm(
                                        show: 1,
                                        onSaved: (value) {
                                          setState(() {
                                            _onSavedWeight = int.parse(value);
                                          });
                                        },
                                        key: ValueKey('weight'),
                                        labelText: 'Weight',
                                        hintText: '......',
                                        icon: Icons.line_weight,
                                        showIcon: false,
                                        textInputType: TextInputType.number,
                                        leftPadding: 15,
                                        rightPadding: 10,
                                        errorValidator: _validateWeightError,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextForm(
                                        //onSubmitted: null,
                                        show: 1,
                                        onSaved: (value) {
                                          setState(() {
                                            _onSavedHeight = int.parse(value);
                                          });
                                        },
                                        key: ValueKey('height'),
                                        labelText: 'Height',
                                        hintText: '......',
                                        icon: Icons.height,
                                        showIcon: false,
                                        textInputType: TextInputType.number,
                                        leftPadding: 10,
                                        rightPadding: 15,
                                        errorValidator: _validateHeightError,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 25,
                              ),
                              TextForm(
                                show: 0,
                                onSaved: (value) {
                                  setState(() {
                                    _onSavedPassword = value;
                                  });
                                },
                                key: ValueKey('password'),
                                labelText: 'Password',
                                hintText: 'Enter Your Password',
                                icon: Icons.lock_outline,
                                showIcon: true,
                                leftPadding: 15,
                                rightPadding: 15,
                                //onSubmitted: trySubmit,
                                errorValidator: _validatePassowrdError,
                              ),
                              if (isLogIN)
                                Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor: Colors.white30,
                                      ),
                                      child: CheckBox(),
                                    ),
                                    Text(
                                      'Remeber Me',
                                      style: TextStyle(
                                          color: Colors.white30, fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 26,
                                    ),
                                    Text(
                                      'Forgot Your Password ?',
                                      style: TextStyle(
                                          color: Colors.white30, fontSize: 13),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Stack(children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: isLogIN ? 447.5 : 607.5, left: 33.5),
                    height: 85,
                    width: 285,
                    decoration: BoxDecoration(
                        color: Color(0xff2D2940),
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.0,
                              spreadRadius: 10.5,
                              color: Color(0xff232035))
                        ]),
                  ),
                  GestureDetector(
                    onTap: trySubmit,
                    child: Container(
                      margin:
                          EdgeInsets.only(top: isLogIN ? 460 : 620, left: 48),
                      height: 62,
                      width: 260,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff46DFC9), Color(0xff37779A)]),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 0,
                                spreadRadius: 0,
                                color: Color(0xff232038))
                          ]),
                      child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  isLogIN ? 'Log In' : 'Sign Up',
                                  style: TextStyle(
                                      color: Color(0xff2F2C41),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                )),
                    ),
                  ),
                ])
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class LogoText extends StatelessWidget {
  final String textName;
  final Function onTap;

  const LogoText({this.textName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        textName,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.lightBlue, fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}
