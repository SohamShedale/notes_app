import 'package:authentication/services/database_service.dart';
import 'package:authentication/utils/search_cards.dart';
import 'package:authentication/utils/show_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:authentication/widgets/build_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  final DatabaseService _databaseService = DatabaseService.instance;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController searchController;
  List<Map<String, dynamic>>? data;
  dynamic searchedData = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    searchController = TextEditingController();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final loadedData = await _databaseService.getNotes();
      setState(() {
        data = loadedData;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          onChanged: (String value) async {
            if (value.isEmpty) {
              setState(() {
                searchedData = [];
              });
            }
            try {
              final result = await searchCards(data, value);
              if (result.isEmpty) {
                setState(() {
                  searchedData = "Match not found";
                });
              } else {
                setState(() {
                  searchedData = result;
                  print(searchedData);
                });
              }
            } catch (e) {
              print(e.toString());
              setState(() {
                searchedData = [];
              });
            }
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
                icon: Icon(Icons.menu),
              );
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
        child: data != null
            ? (data!.isNotEmpty)
                ? (searchedData is String)
                    ? Center(
                        child: Text(
                          searchedData,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: Column(
                          children: [
                            Expanded(
                              child: MasonryGridView.builder(
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: (searchedData.isNotEmpty)
                                    ? searchedData.length
                                    : (data != null)
                                        ? data!.length
                                        : 0,
                                itemBuilder: (context, index) {
                                  final toDisplayItems =
                                      (searchedData.isNotEmpty)
                                          ? searchedData
                                          : data;
                                  final item = toDisplayItems![index];
                                  return BuildCard(item: item);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                : Center(
                    child: Text(
                      "No notes yet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
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
