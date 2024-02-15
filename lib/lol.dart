import 'package:flutter/material.dart';
import 'ticTacToe.dart';
var game = TicTacToe();

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  late Color _buttonColor;

  @override
  void initState() {
    //Начальное значение цвета кнопки
    _buttonColor = Colors.red;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //Здесь меняем переменную цвета кнопки внутри state
        setState(() {
          if (_buttonColor == Colors.red) {
            _buttonColor = Colors.green;
          } else {
            _buttonColor = Colors.red;
          }
        });
      },
      style: ElevatedButton.styleFrom(
        //Здесь указывается, что для цвета нужно взять переменную
        primary: _buttonColor,
      ),
      child:
    );
  }
}