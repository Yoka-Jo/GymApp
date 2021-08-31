import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_HB/provider_HB.dart';

class SetsShape extends StatefulWidget {
  @override
  _SetsShapeState createState() => _SetsShapeState();
}

class _SetsShapeState extends State<SetsShape> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Provider.of<ProviderHelper>(context, listen: false).formKey,
      child: SingleChildScrollView(
          child: Column(
        children: [
          ..._getRepsWeight(),
        ],
      )),
    );
  }

  List<Widget> _getRepsWeight() {
    final repsList =
        Provider.of<ProviderHelper>(context, listen: false).repsList;
    List<Widget> repsWeightTextFields = [];

    for (int i = 0; i < repsList.length; i++) {
      repsWeightTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Row(
          children: [
            Expanded(child: SetsTextFields(i)),
            SizedBox(
              width: 2,
            ),
          ],
        ),
      ));
    }

    return repsWeightTextFields;
  }
} ///The end of formState

//////////////////////////////////////////////////////////////////////
class SetsTextFields extends StatefulWidget {
  final int index;

  SetsTextFields(this.index);

  @override
  _SetsTextFieldsState createState() => _SetsTextFieldsState();
}

class _SetsTextFieldsState extends State<SetsTextFields> {
  TextEditingController _repsController;
  TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _repsController.text = Provider.of<ProviderHelper>(context, listen: false)
              .repsList[widget.index] ??
          '';

      _weightController.text=
          Provider.of<ProviderHelper>(context, listen: false)
                  .weightList[widget.index] ??
              '';
    });

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Color(0xff195558)),
              child: Center(
                  child: FittedBox(
                child: Text(
                  'Set ${widget.index + 1}',
                  style: TextStyle(
                      color: Colors.white38, fontWeight: FontWeight.bold),
                ),
              )),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                    height: 15,
                    child: Image.asset(
                      'assets/images/repeat.png',
                      color: Colors.blue,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text('Reps',
                    style: TextStyle(
                        color: Colors.white38, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 45,
              width: 120,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Color(0xff39364B)),
              child: TextFormField(
                decoration: InputDecoration(
                  // error
                   errorStyle: TextStyle(height: 0.0),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                controller: _repsController,
                textAlign: TextAlign.center,
                onChanged: (v) =>
                    Provider.of<ProviderHelper>(context, listen: false)
                        .repsList[widget.index] = v,
                validator: (v) {
                  if (v.trim().isEmpty) return '';
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        SizedBox(
          width: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              children: [
//            SizedBox(
//              width: 10,
//            ),
                SizedBox(
                    height: 15,
                    child: Image.asset(
                      'assets/images/dumbbell.png',
                      color: Colors.blue,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text('Weight(kgs)',
                    style: TextStyle(
                        color: Colors.white38, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 45,
              width: 120,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Color(0xff39364B)),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                   errorStyle: TextStyle(height: 0.0),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: _weightController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      Provider.of<ProviderHelper>(context, listen: false)
                          .weightList[widget.index] = v,
                  validator: (v) {
                    if (v.trim().isEmpty) return '';
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }
}
