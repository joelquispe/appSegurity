
import 'package:flutter/material.dart';
class WButton extends StatelessWidget {
  final String texto;
  final void Function()? pressed;
  const WButton({Key? key, required this.texto, this.pressed})
      : super(key: key);

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
        child: Center(
            child: Text(
          texto,
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
