import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_HB/provider_HB.dart';
class MonthsDrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.only(left: 20),
height: 40,
width: 130,
decoration: BoxDecoration(
color: Color(0xff39364B),
borderRadius: BorderRadius.all(Radius.circular(5))
),
child: Provider.of<ProviderHelper>(context).monthsDropDown(),
);
  }
}
