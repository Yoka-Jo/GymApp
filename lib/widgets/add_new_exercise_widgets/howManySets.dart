import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/widgets/add_new_exercise_widgets/setsShape.dart';
import '../../provider_HB/provider_HB.dart';

class HowManySets extends StatefulWidget {
  @override
  _HowManySetsState createState() => _HowManySetsState();
}

class _HowManySetsState extends State<HowManySets> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context, listen: false);
    return Container(
      padding: EdgeInsets.only(right: 10, left: 15),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff2D2940),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 1),
        ],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text('How many sets', style: TextStyle(color: Colors.white)),

            SizedBox(
              height: 10,
            ),

            Container(
              height: 45,
              width: 280,
              decoration: BoxDecoration(
                  color: Color(0xff39364B),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      provider.decreaseSets(
                          Provider.of<ProviderHelper>(context , listen: false).setsNumber
                      );
                    },
                  ),
                  Spacer(),
                  Text(
                    '${Provider.of<ProviderHelper>(context , listen: false).setsNumber + 1}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ),
                    onPressed:
                        Provider.of<ProviderHelper>(context)
                            .increaseSets,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 8,
            ),

            SetsShape()
          ],
        ),
      ),
    );
  }
}
