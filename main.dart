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
    double bill = 0.0;
    double tipPercent = 0.0;
    double tip = 0.0;
    double tipDecimalPercent = 0.0;
    void calculateTip(){
      tipDecimalPercent = tipPercent/100.0;
      setState(() {
        tip = bill*tipDecimalPercent;
      });
    }
    void clear(){
      bill = 0.0;
      tipPercent = 0.0;
      tipDecimalPercent = 0.0;
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.blueGrey[300],
        appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(100) ),
          backgroundColor:const Color.fromARGB(255, 19, 17, 121),
          title: const Center(child:Text("Tip Calclator"),)
        ),
        body: 
        Stack(
          children: [
            Positioned(
              top: 40,
              right:50,
              child: Container(
              color: const Color.fromARGB(255, 250, 225, 3),
              width: 300,
              height: 30,
              child: Text("Bill: $bill"),
            ),
            ),
            Positioned(
              top: 80,
              right:50,
              child: Container(
              color: const Color.fromARGB(255, 250, 225, 3),
              width: 300,
              height: 30,
              child: Text("Tip Percent: $tipPercent"),
            ),
            ),
            Positioned(
              bottom: 80,
              right:160,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.redAccent[700],
                  borderRadius: BorderRadius.circular(360),
                  border: Border.all(width: 10, color: const Color.fromARGB(255, 227, 89, 79))
                ),
                child: TextButton(
                  onPressed: calculateTip,
                  child: const Center(
                    child: Text("Enter"),
                    ),  
                  )
              ),
            ),
            Positioned(
              top: 120,
              right:50,
              child: Container(
              color: const Color.fromARGB(255, 3, 250, 98),
              width: 300,
              height: 80,
              child: Text("Tip: $tip", style: const TextStyle(fontSize: 60, fontStyle: FontStyle.italic),
              ),
            ),
            ),
    
            Positioned(
              bottom: 50,
              right: 50,
              child:Container(
              color: Colors.orange,
              width: 100,
              height: 50,
              child: TextButton(
                onPressed: (){
                  setState(() {
                    bill++;
                  });
                },
                child: const Center(child: Text('bill'),),
              )
            ),
            ),
            Positioned(
              bottom: 50,
              left: 50,
              child:Container(
              color: Colors.red,
              width: 100,
              height: 50,
              child: TextButton(
                child: const Center(child:Text("Tip Percentage")),
                onPressed: () {
                  setState(() {
                    tipPercent++;
                  });
                },
              ),
            ),
            ),
            Positioned(
              bottom: 20,
              right:180,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(color: Color.fromARGB(255, 101, 147, 182)),
                child: TextButton(
                  onPressed: clear,
                  child: const Center(
                    child: Text("Clear"),
                    ),  
                  )
              ),
            )
          ],
        ),
      )
    );
  }
}


