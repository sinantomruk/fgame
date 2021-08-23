import 'package:bonfire/bonfire.dart';
import 'package:fgame/minesweeper.dart';
import 'package:fgame/ninjagame/ninja_game.dart';
import 'package:fgame/tictactoe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        "/ninjagame": (context) => NinjaGame(),
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
            ElevatedButton(
              onPressed: () async {
                if (!kIsWeb) {
                  await Flame.device.setLandscape();
                  await Flame.device.fullScreen();
                }
                Navigator.of(context).pushNamed("/ninjagame");
              },
              child: Text("Ninja Game"),
            ),
          ],
        ),
      ),
    );
  }
}
