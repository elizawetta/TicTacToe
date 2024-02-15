class TicTacToe{
  List<List<int>> field = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
  int turn = 1;
  bool gameOver = false;
  int x = 0;
  int o = 0;
  bool cnt = false;

  void makeMove(int n){
    var x = n ~/ 3;
    var y = n % 3;
    if (field[x][y] == 0 && gameOver == false){
      field[x][y] = turn;
      turn = turn == 1 ? 2 : 1;

    }

  }
  checkField() {
    gameOver = true;
    for (int i = 0; i < 3; i++){
      if (field[i][0] == field[i][1] && field[i][0] == field[i][2] && field[i][0] != 0){
        return [i * 3 + 0, i * 3 + 1, i * 3 + 2];
      }
      if (field[0][i] == field[1][i] && field[0][i] == field[2][i] && field[0][i] != 0){
        return [i, i + 3, 6 + i];
      }
    }
    if (field[0][0] == field[1][1] &&  field[0][0] == field[2][2] && field[0][0] != 0){
       return [0, 4, 8];
    }
    if (field[0][2] == field[1][1] &&  field[1][1] == field[2][0] && field[1][1] != 0){
      return [2, 4, 6];
    }
    gameOver = false;

    return [];

  }
  void clearField(){
    field = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
    turn = 1;
    gameOver = false;
    cnt = false;
  }
  getValue(int n){
    var x = n ~/ 3;
    var y = n % 3;
    return field[x][y];
  }




}
