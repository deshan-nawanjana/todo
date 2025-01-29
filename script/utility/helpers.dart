import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<dynamic> loadData() async {
  // get data file in documents
  final Directory root = await getApplicationDocumentsDirectory();
  final File file = File("${root.path}/todo.app.data.json");
  // check data file existence
  if (await file.exists()) {
    // return data object
    return json.decode(await file.readAsString());
  } else {
    // return initial object
    return {"items": [], "theme": "dark"};
  }
}

Future<dynamic> saveData(data) async {
  // get data file in documents
  final Directory root = await getApplicationDocumentsDirectory();
  final File file = File("${root.path}/todo.app.data.json");
  // write into data file
  return await file.writeAsString(json.encode(data), mode: FileMode.write);
}

ThemeData getThemeByName(String name) {
  // dark mode flag
  bool isDark = name == "dark";
  // switch colors by theme
  Color primaryColor = Color.fromARGB(255, 10, 182, 171);
  Color titleColor = Color.fromARGB(255, 21, 21, 21);
  Color textColor = isDark
      ? Color.fromARGB(255, 255, 255, 255)
      : Color.fromARGB(255, 0, 0, 0);
  Color switchColor = isDark
      ? Color.fromARGB(255, 255, 255, 255)
      : Color.fromARGB(100, 0, 0, 0);
  Color backgroundColor = isDark
      ? Color.fromARGB(255, 21, 21, 21)
      : Color.fromARGB(255, 255, 255, 255);
  // generate theme data
  return ThemeData(
    appBarTheme: AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: titleColor,
      ),
    ),
    scaffoldBackgroundColor: backgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Color.fromARGB(255, 21, 21, 21),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: Color.fromARGB(180, 0, 0, 0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: textColor.withAlpha(120),
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: TextStyle(
        color: textColor.withAlpha(120),
        fontWeight: FontWeight.w500,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
          width: 1.5,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: textColor.withAlpha(160),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: Color.fromARGB(100, 10, 182, 171),
      selectionHandleColor: primaryColor,
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }
        return Color.fromARGB(120, 255, 255, 255);
      }),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected) && !isDark) {
          return Color.fromARGB(255, 255, 255, 255);
        }
        return switchColor;
      }),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: textColor.withAlpha(10),
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: textColor.withAlpha(220),
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 16,
        color: textColor.withAlpha(120),
        fontWeight: FontWeight.normal,
      ),
      iconColor: textColor.withAlpha(140),
    ),
  );
}
