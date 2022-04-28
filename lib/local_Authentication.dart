import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class localAuth extends StatefulWidget {
  const localAuth({Key? key}) : super(key: key);

  @override
  State<localAuth> createState() => _localAuthState();
}

class _localAuthState extends State<localAuth> {
  LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _autherized = 'Not Autherized!';

  Future<void> _checkBiometrics() async {
    bool? canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType>? availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan Fingerprint to authenticate!',
        useErrorDialogs: true,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _autherized = authenticated ? 'Autherized' : 'Not Autherized!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Can Check Biometrics:  ${_canCheckBiometrics}'),
            FlatButton(
              onPressed: _checkBiometrics,
              child: Text(' CHECK '),
            ),
            Text('Get Available Biometrics:  ${_availableBiometrics}'),
            FlatButton(
              onPressed: _getAvailableBiometrics,
              child: Text(' GET '),
            ),
            Text('Authenticate With Local Auth:  ${_autherized}'),
            FlatButton(
              onPressed: _authenticate,
              child: Text('Authenticate Now!'),
            ),
          ],
        ),
      ),
    );
  }
}
