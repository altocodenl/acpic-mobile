import 'package:flutter/material.dart';

// class SnackbarGlobal {
//   SnackbarGlobal._();
//   static buildSnackbar(
//       BuildContext context, String message, String backgroundColorSnackbar) {
//     Scaffold.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           '$message',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Montserrat',
//             fontSize: 16,
//             color: Color(0xFF333333),
//           ),
//         ),
//         backgroundColor: Color(backgroundColorSnackbar == 'green'
//             ? 0xFF04E762
//             : backgroundColorSnackbar == 'red'
//                 ? 0xFFD33E43
//                 : 0xFFffff00),
//         // Todo: turn the nested ternaries into a Map
//         //  var colors = {green: '#04E762', red: '#D33E43', yellow: '#ffff00'};
//       ),
//     );
//   }
// }

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
        // elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
