import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/provider_HB/provider_HB.dart';
import 'package:test_app/screens/edit_user_screen.dart';
import 'package:test_app/screens/login/logo_screen.dart';
import 'package:test_app/shared/components/background_color.dart';
import 'package:test_app/shared/network/local/cache_helper.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/UserInfoScreen';

  @override
  Widget build(BuildContext context) {
    final  data = Provider.of<ProviderHelper>(context).model;
    return BackgroundColor(
      onBackgroundWidget: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false, // Don't show the leading button
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                data.name,
                style: TextStyle(
                  height:1.5 ,
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0 , overflow: TextOverflow.ellipsis)
                    ,

              ) ,
                dropDownMenu(context, data),
              ],
            ),
          ),
          body: data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: Offset(0, 15)),
                            ],
                            color: Color(0xff2D2940),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 20, top: 10),
                                  width: double.infinity,
                                  child: Text(
                                    'Personal Info',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.start,
                                  )),
                              Divider(
                                color: Colors.white30,
                                indent: 20,
                                endIndent: 20,
                              ),
                              userDataTitle('Full Name'),
                              SizedBox(
                                height: 10,
                              ),
                              userDataContainer(
                                icon: Icons.person_outline,
                                userData: data.name,
                                rightPadding: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              userDataTitle('Weight'),
                              SizedBox(
                                height: 10,
                              ),
                              userDataContainer(
                                icon: Icons.line_weight,
                                userData: data.weight.toString(),
                                rightPadding: 80,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              userDataTitle('height'),
                              SizedBox(
                                height: 10,
                              ),
                              userDataContainer(
                                icon: Icons.height,
                                userData: data.height.toString(),
                                rightPadding: 140,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.blue,
                              iconSize: 50,
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
    );
  }

  Widget userDataContainer(
          {String userData, IconData icon, double rightPadding}) =>
      Container(
        margin: EdgeInsets.only(left: 20, right: rightPadding),
        height: 50,
        width: 282,
        decoration: BoxDecoration(
          color: Color(0xff39364B),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(
              icon,
              color: Colors.blue,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              userData,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      );

  Widget userDataTitle(String title) => Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(color: Colors.white30, fontWeight: FontWeight.w500),
      ));

  Widget dropDownMenu(context, UserModel model) => DropdownButton(
        dropdownColor: Color(0xff2D2940),
        underline: Container(),
        icon: Icon(
          Icons.settings_outlined,
          color: Colors.white,
        ),
        items: [
          DropdownMenuItem(
            child: Container(
              child: Row(children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  'Edit',
                  style: TextStyle(color: Colors.white),
                ),
              ]),
            ),
            value: 'Edit',
          ),
          DropdownMenuItem(
            child: Container(
              child: Row(children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ]),
            ),
            value: 'Logout',
          ),
        ],
        onChanged: (itemIdentifier) {
          if (itemIdentifier == 'Logout') {
            FirebaseAuth.instance.signOut().then((value) {
              CacheHelper.deleteData(key: "uId").then((value) =>
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LogoScreen())));
            });
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditUserScreen(userModel: model)));
          }
        },
      );
}
