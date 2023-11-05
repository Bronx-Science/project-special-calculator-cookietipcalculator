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
  double bill2 = 0.0; //storing the bill for a different feature
  int amountOfPeople = 0;
  double splitBill = 0.0; //data for the extra feature where the bill is split between an amount of people
  String history = ""; //saving the information in the string that can be used later on.

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
            title: const Text("Tip Calclator"), //name of the app
          ),
          body: Center( //actual tip calculator
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 400, //text box for putting in thr bill.
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
                        } //checks the input of the bill and stores it to the bill location
                      },
                    ))),
                Container( //making the test box for the tip percentage
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
                      onChanged: (value) { //checks the input given for the tip percent
                        if (double.tryParse(value) != null) {
                          tipPercent = double.parse(value);
                        } else {
                          tipPercent = 0;
                        }
                      },
                    )),
                Container( //box to display thr tip that the person would pay
                  width: 500,
                  height: 60,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, style: BorderStyle.solid),
                      color: const Color.fromARGB(255, 214, 255, 230),
                      borderRadius: BorderRadius.circular(360)),
                  child: Text(
                    "  Tip: $tip",//the tip is calculated and shown in this widget
                    style: const TextStyle(
                        fontSize: 40, fontStyle: FontStyle.italic),
                  ),
                ),
                Container(//enter button where the claculation happens
                    width: 140,
                    height: 140,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.redAccent[700],
                        borderRadius: BorderRadius.circular(500),
                        border: Border.all(
                            width: 10, color: const Color(0xff030303))),
                    child: TextButton(
                      onPressed: calculateTip, //function of the enter button to get the tip
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
          drawer: Drawer( //drawer with the scaffold to hold other features for the app like splitting thr bill and the history
            backgroundColor: const Color.fromARGB(255, 159, 180, 182),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text( //title for the drawer
                    "Extra Features",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.tealAccent, fontSize: 30),
                  ),
                  Container( //box to show the split bill feature
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
                          const Text('Splitting the Bill', //title of the box for the extra feature
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic)),
                          TextField( //input for the bill which is stored in the varible bill2
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
                              }//checks and validates the input
                            },
                          ),
                          TextField( //textbox to put in the amount of people the bill will be split to 
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
                            }, //checks the value of the people (if zero, it will return the orginal bill for the answer)
                          ),
                          Text('Split bill between each person: $splitBill'), //displaying the split bill
                          Container( //enter button very simaler to the one that calculates tip
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
                                onPressed: calculateSplitBill, //function to calculate split bill
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
                  Container( //new box to store the history of claculations
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        color: const Color(0xff2f8dcb),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                            width: 5, color: const Color(0xff030303))),
                    child: ListView( //sliding view to see the long text string that stores the values
                      children: [
                        const Text(
                          "History", //title of the box
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          history,//the history is stored in this varibles and is displayed
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