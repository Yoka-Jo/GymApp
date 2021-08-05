import 'package:flutter/material.dart';
import '../provider_HB/provider_HB.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectTypeScreen extends StatelessWidget {
  final List<QueryDocumentSnapshot> data;
  SelectTypeScreen(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          children: data.map((DocumentSnapshot value) {
            return Container(
              height: 28,
              margin: EdgeInsets.symmetric(
                  horizontal: 5, vertical: 4),
              child: Consumer<ProviderHelper>(
                builder: (context, provider, _) =>
                    RaisedButton(
                      color: provider.selectedItem ==
                          value.data()['title']
                          ? Colors.blue.shade400
                          : Color(0xff39364B),
                      padding:
                      EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30)),
                      child: FittedBox(
                        child: Text(
                          value.data()['title'],
                          style: TextStyle(
                              color: provider
                                  .selectedItem ==
                                  value.data()['title']
                                  ? Colors.white
                                  : Colors.blue,
                              fontSize: 11),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<ProviderHelper>(context,
                            listen: false)
                            .updateColor(
                            value.data()['title']);
                      },
                      onLongPress: () {
                        return showDialog(
                          context: context,
                          builder: (ctx) =>
                              AlertDialog(
                                backgroundColor:
                                Color(0xff2D2940),
                                title: Text('Are You Sure!',
                                    style: TextStyle(
                                        color: Colors
                                            .white)),
                                content: Text(
                                  'You are about to delete this one.',
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(
                                            context)
                                            .pop();
                                      },
                                      child: Text('No')),
                                  FlatButton(
                                      onPressed: () async {
                                        Navigator.of(
                                            context)
                                            .pop();
                                        await FirebaseFirestore
                                            .instance
                                            .collection(
                                            'exercisesType')
                                            .doc(value
                                            .data()['title'])
                                            .delete();
                                      },
                                      child: Text('Yes'))
                                ],
                              ),
                        );
                      },
                    ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
