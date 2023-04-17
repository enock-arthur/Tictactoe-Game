import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      title: 'TicTacToe App',
      home: const Tictactoe(),
      
    );
  }
}

class Tictactoe extends StatefulWidget {
  const Tictactoe({super.key});

  @override
  State<Tictactoe> createState() => _TictactoeState();
}

class _TictactoeState extends State<Tictactoe> {
  // Create a 3x3 board
  // Each cell will be represented by a string
  List<List<String>> _board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  // Keep track of the current player (a player can be 'X' or 'O')
  String _player = 'X';
  String _result = '';

  // Make a move
  // This function will be called when a player taps on a cell
  void _play(int row, int col) {
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = _player;
        _checkWin();
        if (_result == '') {
          _player = _player == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  // Check if there is a winner
  // This function will be called after every move
  void _checkWin() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2] &&
          _board[i][0] != '') {
        _result = '${_board[i][0]} is the winner!';
        return;
      }
      if (_board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i] &&
          _board[0][i] != '') {
        _result = '${_board[0][i]} is the winner!';
        return;
      }
    }
    if (_board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] &&
        _board[0][0] != '') {
      _result = '${_board[0][0]} is the winner!';
      return;
    }
    if (_board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0] &&
        _board[0][2] != '') {
      _result = '${_board[0][2]} is the winner!';
      return;
    }
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          return;
        }
      }
    }
    _result = 'Draw!';
  }

  // Reset the game
  // This function will be called when the reset button is pressed
  void _reset() {
    setState(() {
      _board = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
      _player = 'X';
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 75, 6, 107),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          // Draw the board
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(40.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () => _play(row, col),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Color.fromARGB(255, 114, 44, 146),
                        width: 2.0,
                      ),
                      color: _board[row][col] == 'X'
                          ? Color.fromARGB(255, 226, 55, 43)
                          : _board[row][col] == 'O'
                              ? Colors.white
                              : Color.fromARGB(158, 33, 2, 51),
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col],
                        style: const TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Display the current player
          Container(
            //padding: const EdgeInsets.all(.0),
            child: Text(
              'Player $_player turn',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 144, 96, 221),
              ),
            ),
          ),

          // Display the result
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              _result,
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: _result == '' ? Color.fromARGB(0, 83, 34, 34) : Colors.blue,
              ),
            ),
          ),

          // Reset button
          Container(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _reset,
              child: const Text(
                'Play Again',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

