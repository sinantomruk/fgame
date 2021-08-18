import 'package:flutter/material.dart';

class MinesweeperPage extends StatefulWidget {
  final int columnNumber;
  final int rowNumber;
  final int bombNumber;

  MinesweeperPage(this.columnNumber, this.rowNumber, this.bombNumber,
      {Key? key})
      : super(key: key);

  @override
  _MinesweeperPageState createState() => _MinesweeperPageState();
}

class _MinesweeperPageState extends State<MinesweeperPage> {
  int columnNumber = 8;
  int rowNumber = 12;
  int bombNumber = 6;
  int squaresLeft = 12 * 8;
  late List<List<BoardSquare>> board;

  @override
  void initState() {
    super.initState();
    this.columnNumber = this.widget.columnNumber;
    this.rowNumber = this.widget.rowNumber;
    this.bombNumber = this.widget.bombNumber;
    this.squaresLeft = this.columnNumber * this.rowNumber;
    this.board = List.generate(
      this.rowNumber,
      (y) {
        return List.generate(
          this.columnNumber,
          (x) {
            return BoardSquare(x, y);
          },
        );
      },
    );

    _fillBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Minesweeper"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      "Total bombs: ${this.bombNumber}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Squares left: ${this.squaresLeft}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: this.columnNumber * this.rowNumber,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: this.columnNumber,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int x = index % this.columnNumber;
                  int y = index ~/ this.columnNumber;
                  BoardSquare sqr = this.board[y][x];
                  return GestureDetector(
                    onTap: () => _handleTap(x, y),
                    onLongPress: () {
                      sqr.content = Icon(Icons.flag);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !sqr.isOpened
                            ? Colors.black
                            : (sqr.hasBomb ? Colors.red : Colors.deepPurple),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      child: Center(
                        child: sqr.content,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: this._clearBoard,
                icon: Icon(Icons.restart_alt),
                iconSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(int x, y) {
    if (x < 0 || x >= this.columnNumber || y < 0 || y >= this.rowNumber) {
      return;
    }
    BoardSquare sqr = this.board[y][x];
    if (sqr.isOpened) {
      return;
    } else if (sqr.hasBomb) {
      this.board.forEach(
        (element) {
          element.forEach(
            (s) {
              s.isOpened = true;
              s.content = s.hasBomb
                  ? Icon(Icons.gps_fixed)
                  : Text(
                      s.bombsAround.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    );
            },
          );
        },
      );
      setState(() {});
      _showDialog(false);
    } else if (sqr.bombsAround == 0) {
      sqr.isOpened = true;
      sqr.content = Text(
        "",
        style: TextStyle(
          color: Colors.white,
          fontSize: 35,
        ),
      );
      this.squaresLeft -= 1;
      _handleTap(x, y - 1);
      _handleTap(x + 1, y - 1);
      _handleTap(x + 1, y);
      _handleTap(x + 1, y + 1);
      _handleTap(x, y + 1);
      _handleTap(x - 1, y + 1);
      _handleTap(x - 1, y);
      _handleTap(x - 1, y - 1);
    } else {
      setState(() {
        sqr.isOpened = true;
        sqr.content = Text(
          sqr.bombsAround.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
          ),
        );
      });
      this.squaresLeft -= 1;
      if (this.squaresLeft <= this.bombNumber) {
        _showDialog(true);
      }
    }
  }

  void _fillBoard() {
    for (int index = 0; index < this.rowNumber * this.columnNumber; index++) {
      int x = index % this.columnNumber;
      int y = index ~/ this.columnNumber;
      BoardSquare square = this.board[y][x];

      if (x <= 0 && y <= 0) {
        square.adjacents.add(this.board[y][x + 1]);
        square.adjacents.add(this.board[y + 1][x]);
        square.adjacents.add(this.board[y + 1][x + 1]);
      } else if (x <= 0 && y >= rowNumber - 1) {
        square.adjacents.add(this.board[y][x + 1]);
        square.adjacents.add(this.board[y - 1][x]);
        square.adjacents.add(this.board[y - 1][x + 1]);
      } else if (x >= columnNumber - 1 && y <= 0) {
        square.adjacents.add(this.board[y][x - 1]);
        square.adjacents.add(this.board[y + 1][x]);
        square.adjacents.add(this.board[y + 1][x - 1]);
      } else if (x >= columnNumber - 1 && y >= rowNumber - 1) {
        square.adjacents.add(this.board[y][x - 1]);
        square.adjacents.add(this.board[y - 1][x]);
        square.adjacents.add(this.board[y - 1][x - 1]);
      } else if (x <= 0) {
        square.adjacents.add(this.board[y - 1][x]);
        square.adjacents.add(this.board[y + 1][x]);
        square.adjacents.add(this.board[y][x + 1]);
        square.adjacents.add(this.board[y - 1][x + 1]);
        square.adjacents.add(this.board[y + 1][x + 1]);
      } else if (x >= columnNumber - 1) {
        square.adjacents.add(this.board[y - 1][x]);
        square.adjacents.add(this.board[y + 1][x]);
        square.adjacents.add(this.board[y][x - 1]);
        square.adjacents.add(this.board[y - 1][x - 1]);
        square.adjacents.add(this.board[y + 1][x - 1]);
      } else if (y <= 0) {
        square.adjacents.add(this.board[y][x + 1]);
        square.adjacents.add(this.board[y][x - 1]);
        square.adjacents.add(this.board[y + 1][x]);
        square.adjacents.add(this.board[y + 1][x - 1]);
        square.adjacents.add(this.board[y + 1][x + 1]);
      } else if (y >= rowNumber - 1) {
        square.adjacents.add(this.board[y][x + 1]);
        square.adjacents.add(this.board[y][x - 1]);
        square.adjacents.add(this.board[y - 1][x]);
        square.adjacents.add(this.board[y - 1][x - 1]);
        square.adjacents.add(this.board[y - 1][x + 1]);
      } else {
        square.adjacents.add(this.board[y][x + 1]);
        square.adjacents.add(this.board[y][x - 1]);
        square.adjacents.add(this.board[y + 1][x]);
        square.adjacents.add(this.board[y - 1][x]);
        square.adjacents.add(this.board[y - 1][x - 1]);
        square.adjacents.add(this.board[y - 1][x + 1]);
        square.adjacents.add(this.board[y + 1][x - 1]);
        square.adjacents.add(this.board[y + 1][x + 1]);
      }
    }

    List<int> randomList =
        List.generate(this.columnNumber * this.rowNumber, (i) => i);
    randomList.shuffle();
    for (var i = 0; i < this.bombNumber; i++) {
      int x = randomList[i] % this.columnNumber;
      int y = randomList[i] ~/ this.columnNumber;

      this.board[y][x].hasBomb = true;
      for (var item in this.board[y][x].adjacents) {
        item.bombsAround += 1;
      }
    }
  }

  void _clearBoard() {
    this.squaresLeft = this.columnNumber * this.rowNumber;
    for (int index = 0; index < this.rowNumber * this.columnNumber; index++) {
      int x = index % this.columnNumber;
      int y = index ~/ this.columnNumber;
      BoardSquare sqr = this.board[y][x];
      sqr.bombsAround = 0;
      sqr.hasBomb = false;
      sqr.isOpened = false;
      sqr.content = Text(
        "",
        style: TextStyle(
          color: Colors.white,
          fontSize: 35,
        ),
      );
    }

    List<int> randomList =
        List.generate(this.columnNumber * this.rowNumber, (i) => i);
    randomList.shuffle();
    for (var i = 0; i < this.bombNumber; i++) {
      int x = randomList[i] % this.columnNumber;
      int y = randomList[i] ~/ this.columnNumber;

      this.board[y][x].hasBomb = true;
      for (var item in this.board[y][x].adjacents) {
        item.bombsAround += 1;
      }
    }
    setState(() {});
  }

  void _showDialog(bool isWin) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isWin ? Text("You won!!!!") : Text("You lost!!"),
          actions: [],
        );
      },
    );
  }
}

class BoardSquare {
  int xCoordinate;
  int yCoordinate;
  bool hasBomb;
  int bombsAround;
  List<BoardSquare> adjacents = [];
  Widget content = Text(
    "",
    style: TextStyle(
      color: Colors.white,
      fontSize: 35,
    ),
  );
  bool isOpened = false;

  BoardSquare(
    this.xCoordinate,
    this.yCoordinate, {
    this.hasBomb = false,
    this.bombsAround = 0,
  });
}
