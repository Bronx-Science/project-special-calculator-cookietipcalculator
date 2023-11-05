import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double bill = 0.0; //Varibles to help store and do calcultaions with.
  double tipPercent = 0.0;
  double tip = 0.0;
  double tipDecimalPercent = 0.0;
  double bill2 = 0.0;
  int amountOfPeople = 0;
  double splitBill = 0.0;
  String history = "";
  //functions for calculating the tip
  void calculateTip() {
    tipDecimalPercent = tipPercent / 100.0;
    setState(() {
      tip = bill * tipDecimalPercent;
      tip = double.parse(tip.toStringAsFixed(2));
      addHistory(1);
    });
  }

//function to help store values into a text in a drawer in the history widget(found in drawer)
  void addHistory(int x) {
    setState(() {
      if (x == 1) {
        history +=
            "\nBill: $bill \nTip Percentage: $tipPercent \nTip: $tip\n ____________\n";
      } else {
        history +=
            "\nBill: $bill2 \nNumber of People: $amountOfPeople \nBill for each person: $splitBill\n ____________\n";
      }
    });
  }

//function to help calculate the amount of the bill spilt between a certian amount of people
  void calculateSplitBill() {
    setState(() {
      if (amountOfPeople == 0) {
        //checks to get rid of /0 error
        splitBill = bill2;
      } else {
        splitBill = bill2 / amountOfPeople;
        splitBill = double.parse(splitBill.toStringAsFixed(2));
      }
      addHistory(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //base of the app containing the scaffold with the appbar, body, and the drawer.
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 44, 46, 47),
          appBar: AppBar(
            //app bar
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
            backgroundColor: const Color.fromARGB(255, 19, 17, 121),
            title: const Text("Tip Calclator"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 400,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, style: BorderStyle.solid),
                        color: const Color.fromARGB(255, 5, 196, 238),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bill',
                      ),
                      onChanged: (value) {
                        if (double.tryParse(value) != null) {
                          if (value.length <= 9) {
                            bill = double.parse(value);
                          } else {
                            bill = 0;
                          }
                        } else {
                          bill = 0;
                        }
                      },
                    ))),
                Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, style: BorderStyle.solid),
                        color: const Color.fromARGB(255, 5, 196, 238),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tip Percentage',
                      ),
                      onChanged: (value) {
                        if (double.tryParse(value) != null) {
                          tipPercent = double.parse(value);
                        } else {
                          tipPercent = 0;
                        }
                      },
                    )),
                Container(
                  width: 500,
                  height: 60,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, style: BorderStyle.solid),
                      color: const Color.fromARGB(255, 214, 255, 230),
                      borderRadius: BorderRadius.circular(360)),
                  child: Text(
                    "  Tip: $tip",
                    style: const TextStyle(
                        fontSize: 40, fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                    width: 140,
                    height: 140,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.redAccent[700],
                        borderRadius: BorderRadius.circular(500),
                        border: Border.all(
                            width: 10, color: const Color(0xff030303))),
                    child: TextButton(
                      onPressed: calculateTip,
                      child: const Center(
                        child: Text(
                          "Enter",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          drawer: Drawer(
            backgroundColor: const Color.fromARGB(255, 159, 180, 182),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text(
                    "Extra Features",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.tealAccent, fontSize: 30),
                  ),
                  Container(
                      width: 300,
                      height: 350,
                      decoration: BoxDecoration(
                          color: const Color(0xfff4c3db),
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                              width: 5, color: const Color(0xff030303))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const Text('Splitting the Bill',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic)),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              fillColor: Color.fromRGBO(137, 128, 128, 1),
                              labelText: 'Bill',
                            ),
                            onChanged: (value) {
                              if (double.tryParse(value) != null) {
                                bill2 = double.parse(value);
                              } else {
                                bill2 = 0;
                              }
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              fillColor: Color.fromRGBO(137, 128, 128, 1),
                              labelText: 'Amount of people',
                            ),
                            onChanged: (value) {
                              if (int.tryParse(value) != null) {
                                amountOfPeople = int.parse(value);
                              } else {
                                amountOfPeople = 0;
                              }
                            },
                          ),
                          Text('Split bill between each person: $splitBill'),
                          Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent[700],
                                  borderRadius: BorderRadius.circular(360),
                                  border: Border.all(
                                      width: 5,
                                      color: const Color(0xff030303))),
                              child: TextButton(
                                onPressed: calculateSplitBill,
                                child: const Center(
                                  child: Text(
                                    "Enter",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              )),
                        ],
                      )),
                  Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        color: const Color(0xff2f8dcb),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                            width: 5, color: const Color(0xff030303))),
                    child: ListView(
                      children: [
                        const Text(
                          "History",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          history,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}