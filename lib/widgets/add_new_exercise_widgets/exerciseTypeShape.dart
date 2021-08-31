import 'package:flutter/material.dart';
import 'package:test_app/models/exercise_type_model.dart';
import '../../provider_HB/provider_HB.dart';
import 'package:provider/provider.dart';

class SelectedTypeShape extends StatelessWidget {
  final List<ExerciseTypeModel> data;
  SelectedTypeShape(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      height: 150,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Wrap(
          direction: Axis.horizontal,
          children: data.map((ExerciseTypeModel value) {
            String exerciseType = value.title;
            return Container(
              height: 28,
              margin: EdgeInsets.symmetric(
                  horizontal: 5, vertical: 4),
              child: Consumer<ProviderHelper>(
                builder: (context, provider, _) =>
                    ElevatedButton(
                      style: ButtonStyle(
                       backgroundColor: provider.selectedItem ==
                          exerciseType
                          ? MaterialStateProperty.all<Color>(Colors.blue.shade400)
                          : MaterialStateProperty.all<Color>(Color(0xff39364B)),
                      padding:
                      MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 8)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30))),
                      ),
                      child: FittedBox(
                        child: Text(
                          exerciseType,
                          style: TextStyle(
                              color: provider
                                  .selectedItem ==
                                  exerciseType
                                  ? Colors.white
                                  : Colors.blue,
                              fontSize: 11),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<ProviderHelper>(context,
                            listen: false)
                            .updateColor(
                            exerciseType);
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
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                            context)
                                            .pop();
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.of(
                                            context)
                                            .pop();
                                        provider.deleteExerciseType(value.createdAt);
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
