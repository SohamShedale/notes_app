import 'package:authentication/pages/notes_page.dart';
import 'package:authentication/providers/drawer_provider.dart';
import 'package:authentication/providers/notes_provider.dart';
import 'package:authentication/providers/search_notes_provider.dart';
// import 'package:authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesProvider().deleteTrashNote();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => SearchNotesProvider()),
        ChangeNotifierProvider(create: (context) => DrawerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff202124),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        home: NotesPage(),
        // home: SignupPage(),
      ),
    );
  }
}
