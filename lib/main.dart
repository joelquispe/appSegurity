import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:lottie/lottie.dart';
import 'package:pattern_lock/pattern_lock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final LocalAuthentication auth = LocalAuthentication();
  // ···
  void biometric() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  }

  void patternLock() async {
    PatternLock(
      // color of selected points.
      selectedColor: Colors.red,
      // radius of points.
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
        print("pattern is $input");
      },
    );
  }

  void auntenticate() async {
    try {
      final permi = await auth.getAvailableBiometrics();
      bool a = await auth
          .authenticate(
              localizedReason: "localizedReason",
              options: AuthenticationOptions(biometricOnly: false))
          .then((value) {
        print(value);
        return true;
      });
    } catch (e) {}
  }

  void patronAuthenticate() {
    screenLock(
      context: context,
      correctString: '',
      confirmation: true,
      title: Text("Ingrese su patron"),
      digits: 6,
      confirmTitle: Text("Exitoso"),
      didConfirmed: (matchedText) {
        print(matchedText);
        Navigator.pop(context);
      },
    );
  }

  final key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Seguridad de ingreso",style: TextStyle(color: Colors.blue.shade600,fontSize: 30,fontWeight: FontWeight.bold),),
            Lottie.asset("assets/locked-icon.json", height: 400),
            
             WButton(texto: "Biometrico",pressed: (){
              
            },),
             WButton(texto: "Patron",pressed: (){
              
            },),
            WButton(texto: "Pin",pressed: (){

            },)
            

            //         Container(
            //           height: 400,
            //           width: double.infinity,
            //           child: PatternLock(
            //   // color of selected points.
            //   selectedColor: Colors.red,
            //   // radius of points.
            //   pointRadius: 8,
            //   // whether show user's input and highlight selected points.
            //   showInput: true,
            //   key:key ,

            //   // count of points horizontally and vertically.
            //   dimension: 3,
            //   // padding of points area relative to distance between points.
            //   relativePadding: 0.7,
            //   // needed distance from input to point to select point.
            //   selectThreshold: 25,
            //   // whether fill points.
            //   fillPoints: true,
            //   // callback that called when user's input complete. Called if user selected one or more points.
            //   onInputComplete: (List<int> input) {
            //     print("pattern is $input");
            //   },
            // ),
            //         )
          ],
        ),
      ),
    );
  }
}

class WButton extends StatelessWidget {
  final String texto;
  final void Function()? pressed;
  const WButton({Key? key,required this.texto,this.pressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(15)),
        child: Center(child: Text(texto,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
      ),
    );
  }
}
