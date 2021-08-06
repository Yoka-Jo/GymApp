import 'package:flutter/material.dart';
import '../../shared/components/TextField_checkBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/bottom_nav_bar.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  bool isLogIN = true;
  int _userName = 0;
  int _email = 1;
  int _weight = 2;
  int _height = 3;
  int _password = 4;
  bool _isLoading = false;
  String _osuserName = '';
  String _osemail = '';
  String _ospassword = '';
  int _osweight = 0;
  int _osheight = 0;

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
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _osemail.trim(), password: _ospassword.trim());
        } else {
          UserCredential authResult = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _osemail.trim(), password: _ospassword.trim());
          await FirebaseFirestore.instance
              .collection('emails')
              .doc(authResult.user.uid)
              .set({
            'userName': _osuserName.trim(),
            'weight': _osweight,
            'height': _osheight,
            'userId': FirebaseAuth.instance.currentUser.uid,
          });
          Navigator.of(context).pushReplacementNamed(ChosenScreen.routeName);
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
    return Scaffold(
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
                height: isLogIN ? 340 : 450,
                width: 320,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff232038),
                        blurRadius: 1.0,
                        spreadRadius: 2.5,
                        offset:
                            Offset(0.0, 5.0), // shadow direction: bottom right
                      )
                    ], // shadow direction: bottom right
                    color: Color(0xff2F2C41),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
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
                                    _osuserName = value;
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
                                errorCase: _userName,
                              ),
                            if (!isLogIN)
                              SizedBox(
                                height: 15,
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
                                  _osemail = value;
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
                              errorCase: _email,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            if (!isLogIN)
                              Row(
                                children: [
                                  Expanded(
                                    child: TextForm(
                                      show: 1,
                                      onSaved: (value) {
                                        setState(() {
                                          _osweight = int.parse(value);
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
                                      errorCase: _weight,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextForm(
                                      //onSubmitted: null,
                                      show: 1,
                                      onSaved: (value) {
                                        setState(() {
                                          _osheight = int.parse(value);
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
                                      errorCase: _height,
                                    ),
                                  ),
                                ],
                              ),
                            if (!isLogIN)
                              SizedBox(
                                height: 20,
                              ),
                            TextForm(
                              show: 0,
                              onSaved: (value) {
                                setState(() {
                                  _ospassword = value;
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
                              errorCase: _password,
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
                  margin:
                      EdgeInsets.only(top: isLogIN ? 442.5 : 557.5, left: 33.5),
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
                    margin: EdgeInsets.only(top: isLogIN ? 455 : 570, left: 48),
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
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
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
