import 'package:flutter/material.dart';
import 'package:scouting_test/pages/auto_page.dart';
import 'package:scouting_test/pages/comment_page.dart';
import 'package:scouting_test/pages/endgame_page.dart';
import 'package:scouting_test/pages/home_page.dart';
import 'package:scouting_test/pages/teleop_page.dart';
import 'package:scouting_test/utils/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scouting Test",
      theme: ThemeData(
        primarySwatch: Palette.primaryColor,
      ),
      home: const MyHomePage(title: "Scouting App Flutter Mockup"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Page Navigation
  int _selectedPage = 0;
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    AutoPage(),
    TeleopPage(),
    EndgamePage(),
    CommentPage()
  ];
  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Palette.primaryContrast),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Palette.primaryColor,
        unselectedItemColor: Palette.inactiveButton,
        fixedColor: Palette.primaryContrast,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: _onNavigationItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Main",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            label: "Auto",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: "Teleop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Endgame",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info",
          ),
        ],
      ),
      body: _pages[_selectedPage],
    );
  }
}
