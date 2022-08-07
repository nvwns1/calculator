import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.black,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget calcButton(String btntxt, Color btnColor, Color txtColor) {
    return Container(
        child: SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: btnColor, shape: CircleBorder(), shadowColor: btnColor),
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(fontSize: 25, color: txtColor),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:
          AppBar(backgroundColor: Colors.black, title: Text('Calculator App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 100),
                    ),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('AC', Colors.grey, Colors.white),
              calcButton('+/-', Colors.grey, Colors.white),
              calcButton('%', Colors.grey, Colors.white),
              calcButton('/', Colors.amber.shade900, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('7', Colors.grey.shade800, Colors.white),
              calcButton('8', Colors.grey.shade800, Colors.white),
              calcButton('9', Colors.grey.shade800, Colors.white),
              calcButton('x', Colors.amber.shade900, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('4', Colors.grey.shade800, Colors.white),
              calcButton('5', Colors.grey.shade800, Colors.white),
              calcButton('6', Colors.grey.shade800, Colors.white),
              calcButton('-', Colors.amber.shade900, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('1', Colors.grey.shade800, Colors.white),
              calcButton('2', Colors.grey.shade800, Colors.white),
              calcButton('3', Colors.grey.shade800, Colors.white),
              calcButton('+', Colors.amber.shade900, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 155,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800, shape: StadiumBorder()),
                    onPressed: () {},
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    )),
              ),
              calcButton('.', Colors.grey.shade800, Colors.white),
              calcButton('=', Colors.amber.shade900, Colors.white),
            ],
          )
        ],
      ),
    );
  }

  dynamic text = "0";
  dynamic num1 = 0;
  dynamic num2 = 0;
  dynamic result = "";
  dynamic finalresult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(btntxt) {
    if (btntxt == 'AC') {
      text = '0';
      num1 = "0";
      num2 = "0";
      result = "";
      finalresult = '';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btntxt == '= ') {
      if (preOpr == '+') {
        finalresult = add();
      } else if (preOpr == '-') {
        finalresult = sub();
      } else if (preOpr == '*') {
        finalresult = mul();
      } else if (preOpr == '/') {
        finalresult = div();
      }
    } else if (btntxt == '+' ||
        btntxt == '-' ||
        btntxt == 'x' ||
        btntxt == '/' ||
        btntxt == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }
      if (opr == '+') {
        finalresult = add();
      } else if (opr == '-') {
        finalresult = sub();
      } else if (opr == 'x') {
        finalresult = mul();
      } else if (opr == '/') {
        finalresult = div();
      }
      preOpr = opr;
      opr = btntxt;
      result = '';
    } else if (btntxt == '%') {
      result = num1 / 100;
      finalresult = doesContainDecimal(result);
    } else if (btntxt == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalresult = result;
    } else if (btntxt == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalresult = result;
    } else {
      result = result + btntxt;
      finalresult = result;
    }
    setState(() {
      text = finalresult;
    });
  }

  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
