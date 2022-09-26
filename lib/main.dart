import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bomberman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int PlayerPositionX;
  late int PlayerPositionY;

  bool flagPlayerPosition = false;
  int flag = 1;
  String achouPlayer = '';

  Random random = Random();

  List<List<int>> field =
      List.generate(11, (i) => List<int>.generate(15, (j) => 0));

  void initField() {
    for (int i = 1; i < 10; i++) {
      for (int j = 1; j < 14; j++) {
        field[i][j] = 0;
      }
    }
  }

  void printg() {
    for (int i = 1; i < 10; i++) {
      for (int j = 1; j < 14; j++) {
        print(field[i][j]);
      }
      print('---------');
    }
  }

  void explodir(int x, int y) {
    setState(() {
      field[x][y] = 6;

      if (field[x + 1][y] != 3 && ((x + 1) <= 9)) {
        //RIGHT
        field[x + 1][y] = 6;
      }
      if (field[x - 1][y] != 3 && ((x - 1) >= 1)) {
        // LEFT - WORKING
        field[x - 1][y] = 6;
      }
      if (field[x][y + 1] != 3 && ((y + 1) <= 13)) {
        //DOWN
        field[x][y + 1] = 6;
      }
      if (field[x][y - 1] != 3 && ((y - 1) >= 1)) {
        //UP - WORKING
        field[x][y - 1] = 6;
      }
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          field[x][y] = 0;
          if (field[x + 1][y] == 6) field[x + 1][y] = 0;
          if (field[x - 1][y] == 6) field[x - 1][y] = 0;
          if (field[x][y + 1] == 6) field[x][y + 1] = 0;
          if (field[x][y - 1] == 6) field[x][y - 1] = 0;
        });
      });

      for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 14; j++) {
          if (field[i][j] == 1 || field[i][j] == 4) {
            flag = 1;
            achouPlayer = 'achou';
          }
        }
      }

      if (achouPlayer == 'achou') {
        achouPlayer = '';
      } else {
        flag = 0;
        achouPlayer = 'não achou';
      }
      if (flag == 0) {
        print('Acabou o jogo!');
      }
    });
    print('Flag : $flag');
  }

  @override
  void initState() {
    super.initState();

    //Popular campo com fields vazios (livres)
    initField();

    //Gerar Paredes indestrutíveis
    for (int i = 0; i < 25; i++) {
      int randomX = random.nextInt(9) + 1; // De 1 a 9
      int randomY = random.nextInt(13) + 1; // De 1 a 13
      field[randomX][randomY] = 3; //Paredes indestrutíveis
    }

    //Gerar paredes que quebram
    for (int i = 0; i < 35; i++) {
      int randomX = random.nextInt(9) + 1; // De 1 a 9
      int randomY = random.nextInt(13) + 1; // De 1 a 13
      if (field[randomX][randomY] == 0) {
        field[randomX][randomY] = 2; //Paredes que quebram
      }
    }

    //Gerar posição do player
    while (flagPlayerPosition == false) {
      PlayerPositionX = random.nextInt(9) + 1;
      PlayerPositionY = random.nextInt(13) + 1;

      if (field[PlayerPositionX][PlayerPositionY] == 0) {
        field[PlayerPositionX][PlayerPositionY] = 1;
        flagPlayerPosition = true; // De 1 a 13
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TABULEIRO DO JOGO (MAPA)
              Column(
                children: [
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 1,
                        content: field[1][1],
                      ),
                      Field(
                        x: 2,
                        y: 1,
                        content: field[2][1],
                      ),
                      Field(
                        x: 3,
                        y: 1,
                        content: field[3][1],
                      ),
                      Field(
                        x: 4,
                        y: 1,
                        content: field[4][1],
                      ),
                      Field(
                        x: 5,
                        y: 1,
                        content: field[5][1],
                      ),
                      Field(
                        x: 6,
                        y: 1,
                        content: field[6][1],
                      ),
                      Field(
                        x: 7,
                        y: 1,
                        content: field[7][1],
                      ),
                      Field(
                        x: 8,
                        y: 1,
                        content: field[8][1],
                      ),
                      Field(
                        x: 9,
                        y: 1,
                        content: field[9][1],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 2,
                        content: field[1][2],
                      ),
                      Field(
                        x: 2,
                        y: 2,
                        content: field[2][2],
                      ),
                      Field(
                        x: 3,
                        y: 2,
                        content: field[3][2],
                      ),
                      Field(
                        x: 4,
                        y: 2,
                        content: field[4][2],
                      ),
                      Field(
                        x: 5,
                        y: 2,
                        content: field[5][2],
                      ),
                      Field(
                        x: 6,
                        y: 2,
                        content: field[6][2],
                      ),
                      Field(
                        x: 7,
                        y: 2,
                        content: field[7][2],
                      ),
                      Field(
                        x: 8,
                        y: 2,
                        content: field[8][2],
                      ),
                      Field(
                        x: 9,
                        y: 2,
                        content: field[9][2],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 3,
                        content: field[1][3],
                      ),
                      Field(
                        x: 2,
                        y: 3,
                        content: field[2][3],
                      ),
                      Field(
                        x: 3,
                        y: 3,
                        content: field[3][3],
                      ),
                      Field(
                        x: 4,
                        y: 3,
                        content: field[4][3],
                      ),
                      Field(
                        x: 5,
                        y: 3,
                        content: field[5][3],
                      ),
                      Field(
                        x: 6,
                        y: 3,
                        content: field[6][3],
                      ),
                      Field(
                        x: 7,
                        y: 3,
                        content: field[7][3],
                      ),
                      Field(
                        x: 8,
                        y: 3,
                        content: field[8][3],
                      ),
                      Field(
                        x: 9,
                        y: 3,
                        content: field[9][3],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 4,
                        content: field[1][4],
                      ),
                      Field(
                        x: 2,
                        y: 4,
                        content: field[2][4],
                      ),
                      Field(
                        x: 3,
                        y: 4,
                        content: field[3][4],
                      ),
                      Field(
                        x: 4,
                        y: 4,
                        content: field[4][4],
                      ),
                      Field(
                        x: 5,
                        y: 4,
                        content: field[5][4],
                      ),
                      Field(
                        x: 6,
                        y: 4,
                        content: field[6][4],
                      ),
                      Field(
                        x: 7,
                        y: 4,
                        content: field[7][4],
                      ),
                      Field(
                        x: 8,
                        y: 4,
                        content: field[8][4],
                      ),
                      Field(
                        x: 9,
                        y: 4,
                        content: field[9][4],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 5,
                        content: field[1][5],
                      ),
                      Field(
                        x: 2,
                        y: 5,
                        content: field[2][5],
                      ),
                      Field(
                        x: 3,
                        y: 5,
                        content: field[3][5],
                      ),
                      Field(
                        x: 4,
                        y: 5,
                        content: field[4][5],
                      ),
                      Field(
                        x: 5,
                        y: 5,
                        content: field[5][5],
                      ),
                      Field(
                        x: 6,
                        y: 5,
                        content: field[6][5],
                      ),
                      Field(
                        x: 7,
                        y: 5,
                        content: field[7][5],
                      ),
                      Field(
                        x: 8,
                        y: 5,
                        content: field[8][5],
                      ),
                      Field(
                        x: 9,
                        y: 5,
                        content: field[9][5],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 6,
                        content: field[1][6],
                      ),
                      Field(
                        x: 2,
                        y: 6,
                        content: field[2][6],
                      ),
                      Field(
                        x: 3,
                        y: 6,
                        content: field[3][6],
                      ),
                      Field(
                        x: 4,
                        y: 6,
                        content: field[4][6],
                      ),
                      Field(
                        x: 5,
                        y: 6,
                        content: field[5][6],
                      ),
                      Field(
                        x: 6,
                        y: 6,
                        content: field[6][6],
                      ),
                      Field(
                        x: 7,
                        y: 6,
                        content: field[7][6],
                      ),
                      Field(
                        x: 8,
                        y: 6,
                        content: field[8][6],
                      ),
                      Field(
                        x: 9,
                        y: 6,
                        content: field[9][6],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 7,
                        content: field[1][7],
                      ),
                      Field(
                        x: 2,
                        y: 7,
                        content: field[2][7],
                      ),
                      Field(
                        x: 3,
                        y: 7,
                        content: field[3][7],
                      ),
                      Field(
                        x: 4,
                        y: 7,
                        content: field[4][7],
                      ),
                      Field(
                        x: 5,
                        y: 7,
                        content: field[5][7],
                      ),
                      Field(
                        x: 6,
                        y: 7,
                        content: field[6][7],
                      ),
                      Field(
                        x: 7,
                        y: 7,
                        content: field[7][7],
                      ),
                      Field(
                        x: 8,
                        y: 7,
                        content: field[8][7],
                      ),
                      Field(
                        x: 9,
                        y: 7,
                        content: field[9][7],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 8,
                        content: field[1][8],
                      ),
                      Field(
                        x: 2,
                        y: 8,
                        content: field[2][8],
                      ),
                      Field(
                        x: 3,
                        y: 8,
                        content: field[3][8],
                      ),
                      Field(
                        x: 4,
                        y: 8,
                        content: field[4][8],
                      ),
                      Field(
                        x: 5,
                        y: 8,
                        content: field[5][8],
                      ),
                      Field(
                        x: 6,
                        y: 8,
                        content: field[6][8],
                      ),
                      Field(
                        x: 7,
                        y: 8,
                        content: field[7][8],
                      ),
                      Field(
                        x: 8,
                        y: 8,
                        content: field[8][8],
                      ),
                      Field(
                        x: 9,
                        y: 8,
                        content: field[9][8],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 9,
                        content: field[1][9],
                      ),
                      Field(
                        x: 2,
                        y: 9,
                        content: field[2][9],
                      ),
                      Field(
                        x: 3,
                        y: 9,
                        content: field[3][9],
                      ),
                      Field(
                        x: 4,
                        y: 9,
                        content: field[4][9],
                      ),
                      Field(
                        x: 5,
                        y: 9,
                        content: field[5][9],
                      ),
                      Field(
                        x: 6,
                        y: 9,
                        content: field[6][9],
                      ),
                      Field(
                        x: 7,
                        y: 9,
                        content: field[7][9],
                      ),
                      Field(
                        x: 8,
                        y: 9,
                        content: field[8][9],
                      ),
                      Field(
                        x: 9,
                        y: 9,
                        content: field[9][9],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 10,
                        content: field[1][10],
                      ),
                      Field(
                        x: 2,
                        y: 10,
                        content: field[2][10],
                      ),
                      Field(
                        x: 3,
                        y: 10,
                        content: field[3][10],
                      ),
                      Field(
                        x: 4,
                        y: 10,
                        content: field[4][10],
                      ),
                      Field(
                        x: 5,
                        y: 10,
                        content: field[5][10],
                      ),
                      Field(
                        x: 6,
                        y: 10,
                        content: field[6][10],
                      ),
                      Field(
                        x: 7,
                        y: 10,
                        content: field[7][10],
                      ),
                      Field(
                        x: 8,
                        y: 10,
                        content: field[8][10],
                      ),
                      Field(
                        x: 9,
                        y: 10,
                        content: field[9][10],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 11,
                        content: field[1][11],
                      ),
                      Field(
                        x: 2,
                        y: 11,
                        content: field[2][11],
                      ),
                      Field(
                        x: 3,
                        y: 11,
                        content: field[3][11],
                      ),
                      Field(
                        x: 4,
                        y: 11,
                        content: field[4][11],
                      ),
                      Field(
                        x: 5,
                        y: 11,
                        content: field[5][11],
                      ),
                      Field(
                        x: 6,
                        y: 11,
                        content: field[6][11],
                      ),
                      Field(
                        x: 7,
                        y: 11,
                        content: field[7][11],
                      ),
                      Field(
                        x: 8,
                        y: 11,
                        content: field[8][11],
                      ),
                      Field(
                        x: 9,
                        y: 11,
                        content: field[9][11],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 12,
                        content: field[1][12],
                      ),
                      Field(
                        x: 2,
                        y: 12,
                        content: field[2][12],
                      ),
                      Field(
                        x: 3,
                        y: 12,
                        content: field[3][12],
                      ),
                      Field(
                        x: 4,
                        y: 12,
                        content: field[4][12],
                      ),
                      Field(
                        x: 5,
                        y: 12,
                        content: field[5][12],
                      ),
                      Field(
                        x: 6,
                        y: 12,
                        content: field[6][12],
                      ),
                      Field(
                        x: 7,
                        y: 12,
                        content: field[7][12],
                      ),
                      Field(
                        x: 8,
                        y: 12,
                        content: field[8][12],
                      ),
                      Field(
                        x: 9,
                        y: 12,
                        content: field[9][12],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Field(
                        x: 1,
                        y: 13,
                        content: field[1][13],
                      ),
                      Field(
                        x: 2,
                        y: 13,
                        content: field[2][13],
                      ),
                      Field(
                        x: 3,
                        y: 13,
                        content: field[3][13],
                      ),
                      Field(
                        x: 4,
                        y: 13,
                        content: field[4][13],
                      ),
                      Field(
                        x: 5,
                        y: 13,
                        content: field[5][13],
                      ),
                      Field(
                        x: 6,
                        y: 13,
                        content: field[6][13],
                      ),
                      Field(
                        x: 7,
                        y: 13,
                        content: field[7][13],
                      ),
                      Field(
                        x: 8,
                        y: 13,
                        content: field[8][13],
                      ),
                      Field(
                        x: 9,
                        y: 13,
                        content: field[9][13],
                      ),
                    ],
                  ),
                ],
              ),
              //BOTAO PARA DAR RESTART
              if (flag == 0)
                Column(
                  children: [
                    Text(
                      'Você morreu!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyHomePage()));
                      },
                      child: Text(
                        'Clique para jogar novamente!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              // CONTROLES DE MOVIMENTAÇÃO
              if (flag != 0)
                Container(
                  height: 220,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          InkWell(
                            onTap: () {
                              var x = PlayerPositionX;
                              var y = PlayerPositionY;
                              setState(() {
                                field[PlayerPositionX][PlayerPositionY] = 4;
                              });
                              Future.delayed(const Duration(milliseconds: 2500),
                                  () {
                                explodir(x, y);
                              });
                            },
                            child: Image.asset(
                              'images/buttoms/bomb-buttom.png',
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (PlayerPositionY != 1) {
                                PlayerPositionY--;
                                if (field[PlayerPositionX][PlayerPositionY] !=
                                    0) {
                                  PlayerPositionY++;
                                  print('Cant move!');
                                } else {
                                  setState(() {
                                    field[PlayerPositionX][PlayerPositionY] = 1;

                                    if (field[PlayerPositionX]
                                            [PlayerPositionY + 1] ==
                                        4) {
                                      field[PlayerPositionX]
                                          [PlayerPositionY + 1] = 5;
                                    } else {
                                      field[PlayerPositionX]
                                          [PlayerPositionY + 1] = 0;
                                    }
                                  });
                                  print(PlayerPositionY);
                                }
                              }
                            },
                            child: Image.asset(
                              'images/buttoms/up.png',
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (PlayerPositionX != 1) {
                                setState(() {
                                  PlayerPositionX--;
                                  if (field[PlayerPositionX][PlayerPositionY] !=
                                      0) {
                                    PlayerPositionX++;
                                    print('Cant move!');
                                  } else {
                                    field[PlayerPositionX][PlayerPositionY] = 1;
                                    if (field[PlayerPositionX + 1]
                                            [PlayerPositionY] ==
                                        4) {
                                      field[PlayerPositionX + 1]
                                          [PlayerPositionY] = 5;
                                    } else {
                                      field[PlayerPositionX + 1]
                                          [PlayerPositionY] = 0;
                                    }

                                    print(PlayerPositionX);
                                  }
                                });
                              }
                            },
                            child: Image.asset(
                              'images/buttoms/left.png',
                              height: 70,
                              width: 70,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (PlayerPositionY != 13) {
                                setState(() {
                                  PlayerPositionY++;
                                  if (field[PlayerPositionX][PlayerPositionY] !=
                                      0) {
                                    PlayerPositionY--;
                                    print('Cant move!');
                                  } else {
                                    field[PlayerPositionX][PlayerPositionY] = 1;
                                    if (field[PlayerPositionX]
                                            [PlayerPositionY - 1] ==
                                        4) {
                                      field[PlayerPositionX]
                                          [PlayerPositionY - 1] = 5;
                                    } else {
                                      field[PlayerPositionX]
                                          [PlayerPositionY - 1] = 0;
                                    }

                                    print(PlayerPositionY);
                                  }
                                });
                              }
                            },
                            child: Image.asset(
                              'images/buttoms/down.png',
                              height: 70,
                              width: 70,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (PlayerPositionX != 9) {
                                setState(() {
                                  PlayerPositionX++;
                                  if (field[PlayerPositionX][PlayerPositionY] !=
                                      0) {
                                    PlayerPositionX--;
                                    print('Cant move!');
                                  } else {
                                    field[PlayerPositionX][PlayerPositionY] = 1;
                                    if (field[PlayerPositionX - 1]
                                            [PlayerPositionY] ==
                                        4) {
                                      field[PlayerPositionX - 1]
                                          [PlayerPositionY] = 5;
                                    } else {
                                      field[PlayerPositionX - 1]
                                          [PlayerPositionY] = 0;
                                    }

                                    print(PlayerPositionX);
                                  }
                                });
                              }
                            },
                            child: Image.asset(
                              'images/buttoms/right.png',
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  Field({
    Key? key,
    required this.x,
    required this.y,
    required this.content,
  }) : super(key: key);

  int x;
  int y;
  int content;

  widget() {
    if (content == 0) {
      return Image.asset('images/chao.png');
    } else if (content == 1) {
      return Image.asset('images/personagem.png');
    } else if (content == 2) {
      return Image.asset('images/parede_que_quebra.png');
    } else if (content == 3) {
      return Image.asset('images/parede.png');
    } else if (content == 4) {
      return Image.asset('images/personagem_bomba.png');
    } else if (content == 5) {
      return Image.asset('images/bomba.png');
    } else if (content == 6) {
      return Image.asset('images/explosao.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget();
  }
}
