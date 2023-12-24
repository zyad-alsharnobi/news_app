import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page.dart';

void main() {
  runApp(const News_App());
}

class News_App extends StatelessWidget {
  const News_App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
