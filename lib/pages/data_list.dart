import 'package:authentication/constants/data.dart';
import 'package:authentication/utils/search_cards.dart';
import 'package:authentication/utils/show_dialog_box.dart';
import 'package:authentication/widgets/build_card.dart';
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
    ...dataItem,
  ];
  List<DataItem> searchedData = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    data = [
      ...dataItem,
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          onChanged: (String value) {
            setState(() {
              searchedData = searchCards(value);
            });
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
            }),
          ),
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
                    return BuildCard(item: item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isItemAdded = await showDialogBox(
              context, titleController, descriptionController);
          if (isItemAdded) {
            setState(() {});
          }
        },
        tooltip: "Add note",
        child: Icon(Icons.add),
      ),
    );
  }
}
