import 'package:flutter/material.dart';
import 'page/home_page.dart';

import 'page/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        SearchPage.route: (context) => const SearchPage(),
      },
    );
  }
}
