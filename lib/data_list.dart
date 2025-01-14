import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DataItem {
  final String title;
  final String description;

  DataItem({required this.title, required this.description});

  @override
  String toString() {
    return 'DataItem{title: $title, description: $description}';
  }
}

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController searchController;

  List<DataItem> data = [
    DataItem(
        title: "Title 1",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident."),
    DataItem(
        title: "Title 2",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    DataItem(
        title: "Title 3",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    DataItem(
        title: "Title 4",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
    DataItem(
        title: "Title 5",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris."),
  ];
  List<DataItem> searchedData = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    searchController = TextEditingController();
  }

  void showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Enter details",
          style: TextStyle(fontSize: 20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter title",
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Enter description",
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                data.add(DataItem(
                  title: titleController.text,
                  description: descriptionController.text,
                ));
                Navigator.pop(context);
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
    ).then((value) {
      titleController.text = "";
      descriptionController.text = "";
    });
  }

  void searchCards(String value) {
    if (value.isEmpty) {
      searchedData = [];
    }
    setState(() {
      searchedData = data
          .where((singleData) =>
              singleData.title.toLowerCase().contains(value.toLowerCase()) ||
              singleData.description
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget buildCard(DataItem item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(item.description),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          onChanged: (String value) {
            searchCards(value);
          },
          controller: searchController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: "Search",
              prefixIcon: Builder(builder: (BuildContext context) {
                return IconButton(
                    onPressed: Scaffold.of(context).openDrawer,
                    icon: Icon(Icons.menu));
              })),
        ),
        backgroundColor: Color.fromRGBO(140, 92, 179, 1),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Notes App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text('My Notes'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Archive'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Trash'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & feedback'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Column(
            children: [
              Expanded(
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: searchedData.isNotEmpty
                      ? searchedData.length
                      : data.length,
                  itemBuilder: (context, index) {
                    final currentList =
                        searchedData.isNotEmpty ? searchedData : data;
                    final item = currentList[index];
                    return buildCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showDialogBox,
        tooltip: "Add note",
        child: Icon(Icons.add),
      ),
    );
  }
}
