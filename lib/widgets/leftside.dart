// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';

class LeftSide extends StatefulWidget {
  LeftSide({Key? key, required this.size,required this.field}) : super(key: key);
  Size size;
  TextField field;

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  bool isTap = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width / 2,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradColor, scaffoldColor],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.0, 1.0])),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    isTap = !isTap;
                  });
                },
                child: Icon(
                  isTap ? Icons.gamepad : Icons.dashboard,
                  color: Colors.black54,
                )),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: widget.field
            )
          ],
        ),
      ),
    );
  }
}
