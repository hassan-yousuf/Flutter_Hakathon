import 'dart:async';
import 'package:flutter/material.dart';

class auth_Sucessfull extends StatefulWidget {
  const auth_Sucessfull({Key? key}) : super(key: key);

  @override
  State<auth_Sucessfull> createState() => _auth_SucessfullState();
}

class _auth_SucessfullState extends State<auth_Sucessfull> {
  @override
  void initState() {
    final Duration duration = Duration(seconds: 2);
    var callback = () async {
      await Navigator.pushNamed(context, '/local_Auth');
    };
    Timer(duration, callback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Congratulation\'s'),
      ),
    );
  }
}
