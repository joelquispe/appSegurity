import 'package:appsegurity/main.dart';
import 'package:appsegurity/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
              "Bienvenido a la seguridad",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Lottie.asset("assets/locked-icon.json", height: 400),
            SizedBox(height:10),
          WButton(
                texto: "Salir",
                pressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Main()), (route) => false);
                },
              )
        ],),
      )),
    );
  }
}
