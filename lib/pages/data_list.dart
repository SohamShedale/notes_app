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
  final List<int> colors = [
    0xff88D8B0,
    0xffFFD166,
    0xff4ECDC4,
    0xffBCAAA4,
    0xffFF6B6B,
    0xffFF9AA2,
    0xffD3D3D3,
    0xff77DD77,
    0xffB39EB5,
    0xffFF6F61,
    0xffD4A5A5,
  ];

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
        backgroundColor: Color(0xff202124),
        title: TextField(
          onChanged: (String value) async {
            if (value.isEmpty) {
              setState(() {
                searchedData = [];
              });
            }
            try {
              final result = await searchCards(data, value);
              setState(() {
                (result.isEmpty)
                    ? searchedData = "Match not found"
                    : searchedData = result;
              });
            } catch (e) {
              print(e.toString());
              setState(() {
                searchedData = [];
              });
            }
          },
          cursorColor: Colors.white,
          controller: searchController,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xff525355),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Builder(builder: (BuildContext context) {
              return IconButton(
                onPressed: Scaffold.of(context).openDrawer,
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff202124),
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Notes App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFD166),
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.lightbulb,
                color: Colors.white,
              ),
              title: Text(
                'My Notes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.archive,
                color: Colors.white,
              ),
              title: Text(
                'Archive',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              title: Text(
                'Trash',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.white,
              ),
              title: Text(
                'Help & feedback',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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
                                    : data!.length,
                                itemBuilder: (context, index) {
                                  final toDisplayItems =
                                      (searchedData.isNotEmpty)
                                          ? searchedData
                                          : data;
                                  final item = toDisplayItems![index];
                                  final color = colors[index % colors.length];
                                  return BuildCard(
                                    item: item,
                                    color: color,
                                  );
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
