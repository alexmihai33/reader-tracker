import 'package:flutter/material.dart';
import 'package:reader_tracker/screens/books_details.dart';
import 'package:reader_tracker/screens/favorites_screen.dart';
import 'package:reader_tracker/screens/home_screen.dart';
import 'package:reader_tracker/screens/saved_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      initialRoute: '/',
      routes: {
        '/home':(context) => HomeScreen(),
        '/saved':(context) => SavedScreen(),
        '/favorites':(context) => FavoritesScreen(),
        '/details':(context) => BookDetailsScren(),
      },
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    SavedScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("BookShelf"),
      ),
      body: Container(
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, 
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
      ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (value) {
          setState(() {
            _currentIndex = value;  
          });
        },
      ),
    );
  }
}
