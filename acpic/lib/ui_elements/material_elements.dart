import 'package:flutter/material.dart';
import 'package:acpic/ui_elements/constants.dart';

class SnackBarGlobal {
  SnackBarGlobal._();
  static buildSnackBar(
      BuildContext context, String message, String backgroundColorSnackBar) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$message',
          textAlign: TextAlign.center,
          style: kSnackBarText,
        ),
        backgroundColor: Color(backgroundColorSnackBar == 'green'
            ? 0xFF04E762
            : backgroundColorSnackBar == 'red'
                ? 0xFFD33E43
                : 0xFFffff00),
        //  var colors = {green: '#04E762', red: '#D33E43', yellow: '#ffff00'};
      ),
    );
  }
}

class SixSecondSnackBar {
  SixSecondSnackBar._();
  static buildSnackBar(
      BuildContext context, String message, String backgroundColorSnackBar) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 6),
        content: Text(
          '$message',
          textAlign: TextAlign.center,
          style: kSnackBarText,
        ),
        backgroundColor: Color(backgroundColorSnackBar == 'green'
            ? 0xFF04E762
            : backgroundColorSnackBar == 'red'
                ? 0xFFD33E43
                : 0xFFffff00),
        //  var colors = {green: '#04E762', red: '#D33E43', yellow: '#ffff00'};
      ),
    );
  }
}

class WhiteSnackBar {
  WhiteSnackBar._();
  static buildSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$message',
          textAlign: TextAlign.left,
          style: kWhiteSnackBarText,
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.only(bottom: 50),
        padding: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.colour, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: kButtonText,
          ),
        ),
      ),
    );
  }
}
