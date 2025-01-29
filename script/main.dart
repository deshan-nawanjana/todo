import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/create.dart';

import 'utility/helpers.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatefulWidget {
  const Todo({super.key});
  @override
  State<Todo> createState() => _Todo();
}

class _Todo extends State<Todo> {
  // global states
  List<dynamic> items = [];
  String theme = "dark";

  void appendItem(item) {
    setState(() {
      items.insert(0, item);
      save();
    });
  }

  void updateItem(id, key, value) {
    setState(() {
      items.firstWhere((item) => item["id"] == id)[key] = value;
      save();
    });
  }

  void deleteItem(id) {
    setState(() {
      items.removeWhere((item) => item["id"] == id);
      save();
    });
  }

  void setTheme(name) {
    setState(() {
      theme = name;
      save();
    });
  }

  void save() {
    saveData({"items": items, "theme": theme});
  }

  @override
  void initState() {
    // load previous data
    loadData().then((data) => setState(() {
          items = data["items"];
          theme = data["theme"];
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo",
      theme: getThemeByName(theme),
      initialRoute: "home",
      routes: {
        "home": (context) => HomePage(
              items: items,
              theme: theme,
              setTheme: setTheme,
              delete: deleteItem,
              update: updateItem,
            ),
        "create": (context) => CreatePage(
              append: appendItem,
            ),
      },
    );
  }
}
