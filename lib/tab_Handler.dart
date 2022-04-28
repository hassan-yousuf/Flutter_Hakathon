import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hakathon/local_Authentication.dart';
import 'package:hakathon/otp_Verification.dart';

class tabHandler extends StatefulWidget {
  const tabHandler({Key? key}) : super(key: key);

  @override
  State<tabHandler> createState() => _tabHandlerState();
}

class _tabHandlerState extends State<tabHandler> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.shade200,
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: [
              Tab(
                text: 'LOCAL AUTH',
              ),
              Tab(
                text: 'OTP',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          localAuth(),
          otpVerification(),
        ]),
      ),
    );
  }
}
