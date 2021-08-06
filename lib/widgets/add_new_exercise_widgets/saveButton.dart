import 'package:flutter/material.dart';
import '../../provider_HB/provider_HB.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context, listen: false);
    print(provider.weightList.length);

    return GestureDetector(
      onTap: () async {
        // try {
        await provider.postUserExercise(context).then((value) {
          Navigator.of(context).pop();
        }).catchError((error) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              'Complete The Form!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).errorColor,
          ));
        });
      }
      // catch(error){
      //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: Duration(seconds: 1),
      //     content: Text(
      //       'Complete The Form!',
      //       style: TextStyle(color: Colors.white),
      //       textAlign: TextAlign.center,
      //     ),
      //     backgroundColor: Theme.of(context).errorColor,
      //   ));
      // }
      // },
      ,
      child: Provider.of<ProviderHelper>(context).isPostUserExercise
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 15, bottom: 10.0),
              height: 50,
              width: 310,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff37779A), Color(0xff46DFC9)]),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Text('Save',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
    );
  }
}
