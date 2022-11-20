import 'package:appsegurity/home.dart';
import 'package:appsegurity/patter.page.dart';
import 'package:appsegurity/widgets.dart';
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
      debugShowCheckedModeBanner: false,
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

  void authBiometric() async {
    try {
      final permi = await auth.getAvailableBiometrics();
      bool a = await auth
          .authenticate(
              localizedReason: "localizedReason",
              options: AuthenticationOptions(biometricOnly: false))
          .then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
        print(value);
        return true;
      });
    } catch (e) {}
  }

  void authPin() {
    screenLock(
      context: context,
      correctString: '',
      didError: ((retries) {
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Pin invalido"),
          behavior: SnackBarBehavior.floating,
        ));
      }),
      confirmation: true,
      title: Text("Ingrese su patron"),
      digits: 4,
      confirmTitle: Text("Confirme su patron"),
      didConfirmed: (matchedText) {
        print(matchedText);
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
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
            Text(
              "Seguridad de ingreso",
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Lottie.asset("assets/locked-icon.json", height: 400),
            WButton(
              texto: "Biometrico",
              pressed: () {
                authBiometric();
              },
            ),
            WButton(
              texto: "Patron",
              pressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => PatterPage()));
              },
            ),
            WButton(
              texto: "Pin",
              pressed: () {
                authPin();
              },
            )
          ],
        ),
      ),
    );
  }
}
