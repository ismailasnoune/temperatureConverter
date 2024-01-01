import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double tempfah = 0, tempcel = 0;
  bool isfah = true;
  String formula = "";
  var fahController = TextEditingController();
  var celController = TextEditingController();
  fahlistener() {
    tempfah = double.parse(fahController.text);
    tempcel = convert(tempfah, true);
    if (isfah) celController.text = tempcel.toStringAsFixed(3);
    isfah = true;
    setState(() {
      formula =
          "(${fahController.text}F° - 32)*5/9 == ${celController.text} C°";
    });
  }

  cellistener() {
    tempcel = double.parse(celController.text);
    tempfah = convert(tempcel, false);
    if (!isfah) fahController.text = tempfah.toStringAsFixed(3);
    isfah = false;
    setState(() {
      formula =
          "(${celController.text}C° * 9/5)+32 == ${fahController.text} F°";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fahController.addListener(() {
      fahlistener();
    });
    celController.addListener(() {
      cellistener();
    });
  }

  double convert(double tmp, bool isf) {
    return isf ? (tmp - 32) * (5 / 9) : tmp * (9 / 5) + 32;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Temperature Converter")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      "Fahrenheit",
                      style: TextStyle(
                          wordSpacing: 2,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixText: "F",
                      ),
                      controller: fahController,
                    ),
                  ],
                )),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      "Celsius",
                      style: TextStyle(
                          wordSpacing: 2,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(suffixText: "C"),
                      controller: celController,
                    )
                  ],
                )),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Formula:",
                  style: TextStyle(
                      backgroundColor: Colors.amber,
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Text(
                    "${formula}",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
