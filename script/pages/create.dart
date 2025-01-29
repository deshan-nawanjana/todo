import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePage extends StatefulWidget {
  final dynamic append;

  const CreatePage({super.key, required this.append});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // input states
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isFavorite = false;
  // method to create item
  void createItem(context) {
    // append item
    widget.append({
      "id": DateTime.now().millisecondsSinceEpoch,
      "name": nameController.text,
      "description": descriptionController.text,
      "time": DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
      "favorite": isFavorite,
      "done": false,
    });
    // back to home screen
    Navigator.of(context).pop();
  }

  @override
  Scaffold build(BuildContext context) {
    bool isEmpty = nameController.text == "";
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: "Task Name"),
              onChanged: (value) => setState(() {}),
              controller: nameController,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: "Description"),
              onChanged: (value) => setState(() {}),
              controller: descriptionController,
              minLines: 1,
              maxLines: 3,
            ),
            Row(
              children: [
                Expanded(child: Text("Add to Favorites")),
                Switch(
                  value: isFavorite,
                  onChanged: (value) {
                    setState(() => isFavorite = value);
                  },
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: !isEmpty
          ? FloatingActionButton(
              onPressed: () => createItem(context),
              shape: CircleBorder(),
              child: Icon(Icons.done),
            )
          : null,
    );
  }
}
