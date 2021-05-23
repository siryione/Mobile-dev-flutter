import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/services/MovieService.dart';
import 'package:flutter_application/view/AddMoviePage.dart';
import 'package:flutter_application/view/ChartPage.dart';
import 'package:flutter_application/view/HomePage.dart';
import 'package:flutter_application/view/MoviePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:NavigationBar(),
      routes: {
        '/afterAddMovie':(_)=> NavigationBar()
      },
    );
  }
}


class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    ChartPage(),
    MoviePage(),
    AddMoviePage(MovieService()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text('Programming assignment'),
            ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
                    BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
