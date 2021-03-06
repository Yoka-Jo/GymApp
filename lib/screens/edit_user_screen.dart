import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/provider_HB/provider_HB.dart';
import 'package:test_app/shared/components/background_color.dart';

// ignore: must_be_immutable
class EditUserScreen extends StatefulWidget {
  final UserModel userModel;
  


   EditUserScreen({Key key, this.userModel}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController nameController;

  TextEditingController heightontroller;

  TextEditingController weightController;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() { 
    super.initState();
    nameController = TextEditingController();
    heightontroller = TextEditingController();
    weightController = TextEditingController();
    nameController.text = widget.userModel.name;
    heightontroller.text = widget.userModel.height.toString();
    weightController.text = widget.userModel.weight.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    heightontroller.dispose();
    weightController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context);
    return BackgroundColor(
      onBackgroundWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 8.0,
          leading: IconButton(
            padding: EdgeInsets.only(left: 10.0),
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
            iconSize: 25,
          ),
          title: Text(
            "Edit User",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if(provider.isUpdated)
              LinearProgressIndicator(),
              SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 100.0, bottom: 50.0),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 20.0,
                            spreadRadius: 5.0,
                            offset: Offset(0, 15)),
                      ],
                      color: Color(0xff2D2940),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                              controller: nameController,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                              decoration: inputDecoration(
                                  hintText: "User Name", prefixIcon: Icons.person)),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextFormField(
                              controller: heightontroller,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration(
                                  hintText: "Height", prefixIcon: Icons.height)),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextFormField(
                              controller: weightController,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration(
                                  hintText: "Weight",
                                  prefixIcon: Icons.line_weight)),
                        ],
                      ),
                    ),
                  ),
                  if(!provider.isUpdated)
                  InkWell(
                    onTap: () async{
                      await provider.updateUser(
                          name: nameController.text,
                          height: heightontroller.text,
                          weight: weightController.text);
                          Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 50,
                      width: 310,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff37779A), Color(0xff46DFC9)]),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({String hintText, IconData prefixIcon}) =>
      InputDecoration(
        fillColor: Color(0xff39364B),
        filled: true,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blue,
        ),
        hintStyle: TextStyle(color: Colors.blue, fontSize: 15.0),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.blue),
            borderRadius: BorderRadius.circular(8.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.1, color: Colors.white),
            borderRadius: BorderRadius.circular(8.0)),
        hintText: hintText,
      );
}
