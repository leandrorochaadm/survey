import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ]),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            color: Colors.black,
          )
        ],
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
      ),
      height: 240,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: 32,
      ),
      // child: Image(image: AssetImage('')),
      child: Text(
        '4D',
        style: TextStyle(
          color: Theme.of(context).backgroundColor,
          fontSize: 100,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
