import 'package:authentication/pages/data_list.dart';
import 'package:authentication/providers/notes_provider.dart';
import 'package:authentication/providers/search_notes_provider.dart';
// import 'package:authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>NotesProvider()),
        ChangeNotifierProvider(create: (context)=>SearchNotesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Color(0xff202124)),
        home: DataList(),
        // home: SignupPage(),
      ),
    );
  }
}
