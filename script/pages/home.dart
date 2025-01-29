import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function setTheme;
  final String theme;
  final List<dynamic> items;
  final Function update;
  final Function delete;

  const HomePage({
    super.key,
    required this.setTheme,
    required this.theme,
    required this.items,
    required this.update,
    required this.delete,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

_getListView(context, section, List data, onDelete, onUpdate) {
  List items =
      section == 0 ? data : data.where((item) => item["favorite"]).toList();
  if (items.isEmpty) {
    return Center(
      child: Text(
        section == 0
            ? "Your task list is empty\nTap on + to create"
            : "You don't have any\nfavorite tasks",
        textAlign: TextAlign.center,
      ),
    );
  } else {
    dynamic theme = Theme.of(context).listTileTheme;
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: items.length,
      itemBuilder: (context, index) {
        dynamic item = items[index];
        int id = item["id"];
        String name = item["name"];
        String description = item["description"];
        bool favorite = item["favorite"];
        bool done = item["done"];
        if (!favorite && section == 1) {
          return SizedBox();
        }
        return Column(
          children: [
            ListTile(
              leading: IconButton(
                onPressed: () => onUpdate(id, "done", !done),
                icon: Icon(done ? Icons.task_alt : Icons.radio_button_off),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: done ? theme.tileColor?.withAlpha(100) : null,
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description != ""
                      ? Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              description,
                              style: TextStyle(
                                color: done
                                    ? theme.subtitleTextStyle?.color
                                        ?.withAlpha(60)
                                    : null,
                              ),
                            ),
                            SizedBox(height: 6),
                          ],
                        )
                      : SizedBox(height: 6),
                  Text(item["time"],
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.subtitleTextStyle?.color?.withAlpha(60),
                      )),
                ],
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 2,
                  children: [
                    IconButton(
                      onPressed: () => onUpdate(id, "favorite", !favorite),
                      icon: Icon(
                        Icons.favorite,
                        color: favorite
                            ? Colors.red
                            : theme.iconColor?.withAlpha(50),
                      ),
                    ),
                    IconButton(
                      onPressed: () => onDelete(id),
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
              horizontalTitleGap: 5,
              contentPadding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
            SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

class _HomePageState extends State<HomePage> {
  int section = 0;

  void setSection(code) {
    setState(() => section = code);
  }

  void createItem(context) {
    Navigator.pushNamed(context, "create");
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(section == 0
              ? "All Tasks"
              : section == 1
                  ? "Favorites"
                  : "Settings"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: section == 2
          ? Container(
              padding: EdgeInsets.all(30),
              child: Row(
                children: [
                  Expanded(child: Text("Dark Mode")),
                  Switch(
                    value: widget.theme == "dark",
                    onChanged: (value) {
                      setState(() => widget
                          .setTheme(widget.theme == "dark" ? "light" : "dark"));
                    },
                  ),
                ],
              ),
            )
          : _getListView(
              context,
              section,
              widget.items,
              widget.delete,
              widget.update,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: section,
        onTap: setSection,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createItem(context),
        elevation: 0,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
