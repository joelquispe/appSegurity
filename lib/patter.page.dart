import 'package:appsegurity/data.dart';
import 'package:appsegurity/home.dart';
import 'package:appsegurity/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';

class PatterPage extends StatefulWidget {
  const PatterPage({Key? key}) : super(key: key);

  @override
  _PatterPageState createState() => _PatterPageState();
}

class _PatterPageState extends State<PatterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Registro de patron"),
            SizedBox(
              height: 400,
              width: double.infinity,
              child: PatternLock(
                // color of selected points.
                selectedColor: Colors.blue,
                
                pointRadius: 8,
                // whether show user's input and highlight selected points.
                showInput: true,
                // count of points horizontally and vertically.
                dimension: 3,
                // padding of points area relative to distance between points.
                relativePadding: 0.7,
                // needed distance from input to point to select point.
                selectThreshold: 25,
                // whether fill points.
                fillPoints: true,
                // callback that called when user's input complete. Called if user selected one or more points.
                onInputComplete: (List<int> input) {
                  
                  numeros = input;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PatterPage2()));
                },
              ),
            ),
            SizedBox(height: 20),
          WButton(texto: "Retroceder",pressed: (){
            Navigator.pop(context);
          },)
          
          ],
        ),
      ),
    );
  }
}

class PatterPage2 extends StatefulWidget {
  const PatterPage2({Key? key}) : super(key: key);

  @override
  _PatterPage2State createState() => _PatterPage2State();
}

class _PatterPage2State extends State<PatterPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Ingresar con patron"),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: PatternLock(
              selectedColor: Colors.red,
              pointRadius: 8,
              showInput: true,
              dimension: 3,
              relativePadding: 0.7,
              selectThreshold: 25,
              fillPoints: true,
              onInputComplete: (List<int> input) {
                if (listEquals(numeros, input) == true) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Patron invalido")));
                }
              },
            ),
          ),
          SizedBox(height: 20),
          WButton(texto: "Retroceder",pressed: (){
            Navigator.pop(context);
          },)
          
        ],
      )),
    );
  }
}
