import 'package:flutter/material.dart';
import 'package:hakathon/cam_Scanner.dart';
import 'package:hakathon/hakathon.dart';
import 'package:hakathon/home_Screen.dart';
import 'package:hakathon/live_Location.dart';
import 'package:hakathon/payment_Gateway.dart';
import 'package:hakathon/qr_Scanner.dart';
import 'package:hakathon/qr_Creater.dart';
import 'package:hakathon/tab_Handler.dart';
import 'package:hakathon/theme_provider.dart';
import 'package:hakathon/webView_App.dart';
import 'package:hakathon/widget.dart';
import 'package:provider/provider.dart';

class BottomHandler extends StatefulWidget {
  const BottomHandler({Key? key}) : super(key: key);

  @override
  State<BottomHandler> createState() => _BottomHandlerState();
}

class _BottomHandlerState extends State<BottomHandler> {
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Dark Theme'
        : 'Light Theme';

    final icon = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? Icon(
            Icons.dark_mode,
            size: 33,
            color: Colors.grey.shade200,
          )
        : Icon(
            Icons.light_mode,
            size: 33,
            color: Colors.yellow,
          );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: icon,
        centerTitle: true,
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w600,
        ),
        iconSize: 20,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
            ),
            label: '',
            tooltip: 'Qr Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code,
            ),
            label: '',
            tooltip: 'Qr Creater',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_sharp,
            ),
            label: '',
            tooltip: 'Capturing',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: '',
            tooltip: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.verified_user,
            ),
            label: '',
            tooltip: 'Auth & Otp',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.adf_scanner,
            ),
            label: '',
            tooltip: 'CamScanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.payment_rounded,
            ),
            label: '',
            tooltip: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.web,
            ),
            label: '',
            tooltip: 'Webview',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_sharp,
            ),
            label: '',
            tooltip: 'Live Locate',
          ),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }

  final tabs = [
    QrScanner(),
    QrCreater(),
    homeScreen(),
    PushNotificationExample(),
    tabHandler(),
    camScanner(),
    paymentGateway(),
    webViewApp(),
    LiveLocation(),
  ];
  int _currentIndex = 0;
}
