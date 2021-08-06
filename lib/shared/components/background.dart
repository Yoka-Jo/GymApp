import 'package:flutter/material.dart';

Widget background()=>          Column(
            children: [
              Container(
                height: 200.0,
                color: Color(0xff232035),
              ),
              Expanded(
                child: Container(
                  color: Color(0xff2D2940),
                ),
              ),
            ],
          );