import 'package:authentication/pages/data_list.dart';
// import 'package:authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(140, 92, 179, 1)),
      home: DataList(),
      // home: SignupPage(),
    );
  }
}
