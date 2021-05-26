import 'package:flutter/material.dart';

import 'HomePage.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffff6101),
      ),
      home: HomePage(),
    );
  }
}
