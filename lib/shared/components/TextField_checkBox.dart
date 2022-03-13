import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({
    Key key,
  }) : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
//      activeColor: Color(0xff2F2C41),
      activeColor: Colors.white30,
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}

class TextForm extends StatefulWidget {
  final int show;
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final bool showIcon;
  final double leftPadding;
  final double rightPadding;
  final String suffixText;
  final int errorValidator;
  final Function onSaved;
  const TextForm(
      {Key key,
      this.labelText,
      this.hintText,
      this.icon,
      this.textInputType,
      this.showIcon,
      this.leftPadding,
      this.rightPadding,
      this.suffixText,
      this.errorValidator,
      @required this.onSaved,
      @required this.show})
      : super(key: key);

  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: widget.rightPadding, left: widget.leftPadding),
      child: TextFormField(
        validator: (value) {
          switch (widget.errorValidator) {
            case 0:
              if (value.isEmpty || value.length < 4) {
                return 'Please Enter at least 4 characters';
              }
              break;
            case 1:
              if (value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email address';
              }
              break;
            case 2:
              if (value.isEmpty) {
                return 'Enter Your Weight';
              }
              break;
            case 3:
              if (value.isEmpty) {
                return 'Enter Your Height';
              } else if (int.parse(value) > 240) {
                return 'Enter A Valid Height';
              }
              break;
            case 4:
              if (value.isEmpty || value.length < 7) {
                return 'Password must be at least 7 characters long.';
              }
              break;
          }
          return null;
        },
        onSaved: widget.onSaved,
        onFieldSubmitted: (value) {}, //widget.onSubmitted,
        obscureText: 1 == widget.show ? false : showPassword,
        keyboardType: widget.textInputType,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.blue),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          contentPadding: EdgeInsets.only(bottom: 10),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.white30,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            widget.icon,
            color: Colors.blue,
          ),
          suffixIcon: widget.showIcon
              ? IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: showPassword ? Colors.white30 : Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorStyle: TextStyle(
            fontSize: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gapPadding: 4,
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 4,
            borderSide: BorderSide(
              color: Colors.white30,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
