// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.halfTriangleDot(color: Colors.black87, size: 50),
            SizedBox(height: 20,),
            Text("Just a Second..",style: editorStyle(color: Colors.black, weight: FontWeight.bold, size: 20),)
          ],
        )),
      ),
    );
  }
}
