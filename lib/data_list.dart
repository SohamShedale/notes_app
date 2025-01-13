import 'package:flutter/material.dart';

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
    DataItem(title: "Title 1", description: "Description for title 1."),
    DataItem(title: "Title 2", description: "Description for title 2."),
    DataItem(title: "Title 3", description: "Short description."),
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
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(item.description),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Notes",
      //     style: TextStyle(color: Colors.white, fontSize: 30),
      //   ),
      //   backgroundColor: Color.fromRGBO(140, 92, 179, 1),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Text(
                "Notes",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
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
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: (searchedData.isNotEmpty)
                      ? searchedData.length
                      : data.length,
                  itemBuilder: (context, index) {
                    final item = (searchedData.isNotEmpty)
                        ? searchedData[index]
                        : data[index];
                    return buildCard(item);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: showDialogBox,
                child: const Text("Add Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
