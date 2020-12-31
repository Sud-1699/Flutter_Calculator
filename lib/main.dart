import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      });
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQ = '';
  var userA = '';

  final myTextstyle = TextStyle(
    fontSize: 25,
    color: Colors.cyan[800],
    fontWeight: FontWeight.bold,
  );

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQ,
                        style: myTextstyle,
                      )),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userA,
                        style: myTextstyle,
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.205,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return ButtonCLick(
                        buttonTap: () {
                          setState(() {
                            userQ = '';
                            userA = '';
                          });
                        },
                        butText: buttons[index],
                        color: Colors.lightGreenAccent,
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return ButtonCLick(
                        buttonTap: () {
                          setState(() {
                            userQ = userQ.substring(0, userQ.length - 1);
                          });
                        },
                        butText: buttons[index],
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    } else if (index == buttons.length - 1 ||
                        index == buttons.length - 2) {
                      return ButtonCLick(
                        buttonTap: () {
                          setState(() {
                            equalPress();
                          });
                        },
                        butText: buttons[index],
                        color: Colors.cyan[700],
                        textColor: Colors.white,
                      );
                    } else {
                      return ButtonCLick(
                        buttonTap: () {
                          setState(() {
                            userQ += buttons[index];
                          });
                        },
                        butText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.cyan[700]
                            : Colors.cyan[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.cyan,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String a) {
    if (a == '%' || a == '/' || a == 'x' || a == '-' || a == '+' || a == '=') {
      return true;
    }
    return false;
  }

  void equalPress() {
    String finalQues = userQ;

    finalQues = finalQues.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQues);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userA = eval.toString();
  }
}
