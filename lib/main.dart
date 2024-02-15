import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ticTacToe.dart';
import 'package:flutter_test/flutter_test.dart';

var game = TicTacToe();

main() => runApp(Main());

class Main extends StatelessWidget {

  const Main({Key? key}) : super(key: key);
  @override
  Widget build (BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    double width = MediaQuery.of(context).size.width*0.9;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sansation_Bold',
      ),
      home:  Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top:height*0.25),
                child: Text('Tic Tac Toe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 50, 159, 0),
                    fontSize: 70,
                  ), textScaleFactor: 1.0
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage('assets/images/x.png'), width: width/4, height: width/4),
                      Image(image: AssetImage('assets/images/o.png'), width: width/4, height: width/4),
                    ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: NewGameButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: const BorderSide(color: Color.fromARGB(255, 50, 159, 0), width: 7),
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => gameView()),
        );
      },
      child: const Text('New game',
        textScaleFactor: 1.0,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }
}

class homeButton extends StatelessWidget {
  const homeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        game.clearField();
        game.x=0;
        game.o=0;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Main()),
        );
      },
      icon: Icon(
          Icons.home,
          color: Color.fromARGB(255, 50, 159, 0),
          size: 100
      ),
    );
  }
}

class restartButton extends StatelessWidget {
  const restartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        game.clearField();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => gameView()),
        );
      },
      icon: Icon(
        Icons.restart_alt,
        size: 100,
        color: Color.fromARGB(255, 50, 159, 0)
      )
    );
  }
}

class Field extends StatefulWidget {
  const Field({Key? key}) : super(key: key);

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {

  double opacity1 = 1.0;
  double opacity2 = 0.5;
  var buttons = {
    0: [0, 1.0], 1: [0, 1.0], 2: [0, 1.0],
    3: [0, 1.0], 4: [0, 1.0], 5: [0, 1.0],
    6: [0, 1.0], 7: [0, 1.0], 8: [0, 1.0],
  };
  var winPositions = [];
  var image = {
    0: 'assets/images/null.png',
    1: 'assets/images/o.png',
    2: 'assets/images/x.png',
  };

  void changeStatus() {
    setState(() {
      if (winPositions.isNotEmpty) {
        for (int i = 0; i < 9; i++) {
          if (winPositions.contains(i) == false) {
            buttons[i]?[1] = 0.42;
          }
        }
      }
      if (game.gameOver == false){
        if (game.turn == 1){
          opacity1 = 1.0;
          opacity2 = 0.42;
        } else {
          opacity2 = 1.0;
          opacity1 = 0.42;
        }
      }
      else if (game.cnt == false){
        game.cnt = true;
        if (game.turn == 2) game.x++;
        else game.o++;
      }
    });
  }

  void check(int num){
    setState(() {
      if (game.gameOver == false && game.getValue(num) == 0){
        game.makeMove(num);
        buttons[num]?[0] = game.turn;
        winPositions = game.checkField();
      }
      changeStatus();
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.9;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height/9, left: width*0.06, right: width*0.06),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: AssetImage('assets/images/x.png'),
                  width: width/4.5, height: width/4.5,
                  opacity: AlwaysStoppedAnimation(opacity1)),
                Text('${game.x}:${game.o}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35,
                    )),
                Image(
                  image: AssetImage('assets/images/o.png'),
                  width: width/4.5, height: width/4.5,
                  opacity: AlwaysStoppedAnimation(opacity2)),
              ]
          ),
        ),
        Column(children: [
          for (int j = 0; j < 3; j++)
            Padding(padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = j*3; i <j*3+3 ; i++)
                    ElevatedButton(key: Key(i.toString()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(
                          color: Color.fromARGB((254*buttons[i]![1]).floor(), 50, 159, 0),
                          width: 7,
                        ),
                        padding:  EdgeInsets.all(width/12),
                      ),
                      onPressed: () => check(i),
                      child: Row(
                        children: [
                          Image(image: AssetImage(image[buttons[i]?[0]]!),
                              height: (width/6), width: (width/6),
                              opacity: AlwaysStoppedAnimation(buttons[i]?[1] as double)
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],)]
    );
  }
}

class gameView extends StatefulWidget {
  const gameView({Key? key}) : super(key: key);

  @override
  gameViewState createState() => gameViewState();
}

class gameViewState  extends State<gameView> {

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Sansation_Bold'),
      home: const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Field(),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [restartButton(), homeButton()],
              ),)
              ,
            ],
          ),
        ),
      ),
    );
  }
}
