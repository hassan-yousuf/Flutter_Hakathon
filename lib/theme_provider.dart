import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade800,
    primaryColor: Colors.black87,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
      ),
      headline2: TextStyle(
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.cyan,
      opacity: 0.8,
    ),
    colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
      ),
      headline2: TextStyle(
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.pinkAccent,
      opacity: 0.8,
    ),
    colorScheme: ColorScheme.light(),
  );
}
