import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        icon: Icon(
          Icons.email,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
