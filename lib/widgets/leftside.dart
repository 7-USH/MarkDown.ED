// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:window_manager/window_manager.dart';

class LeftSide extends StatefulWidget {
  LeftSide({Key? key, required this.size, required this.field,required this.count})
      : super(key: key);
  Size size;
  int count;
  Widget field;

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
              colors: [scaffoldColor, scaffoldColor],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: const [0.0, 1.0])),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isTap = !isTap;
                    });
                  },
                  child: Icon(
                    isTap ? Icons.gamepad : Icons.dashboard,
                    color: Colors.white,
                  )),
              Spacer(),
              Text(widget.count.toString()+" words",style: editorStyle(color: Colors.white, weight: FontWeight.w500, size: 15),)
            ]),
            Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                    height: widget.size.height / 1.15,
                    child: SingleChildScrollView(child: widget.field))),
          ],
        ),
      ),
    );
  }
}
