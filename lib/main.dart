import 'package:fgame/minesweeper.dart';
import 'package:fgame/tictactoe.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/": (context) => HomeScreen(),
        "/tictactoe": (context) => TicTacToePage(),
        "/minesweeper": (context) => MinesweeperPage(8, 12, 16),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
        // primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
      ),
      themeMode: ThemeMode.system,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fgame"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/tictactoe");
              },
              child: Text("Tic Tac Toe"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/minesweeper");
              },
              child: Text("Minesweeper"),
            ),
          ],
        ),
      ),
    );
  }
}
