// ignore_for_file: avoid_unnecessary_containers, unnecessary_new, unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:flutter_md/pages/home_page.dart';
import 'package:flutter_md/widgets/loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class TimeLoader extends StatefulWidget {
  TimeLoader({Key? key}) : super(key: key);

  @override
  State<TimeLoader> createState() => _TimeLoaderState();
}

class _TimeLoaderState extends State<TimeLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.done_outline,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text("Pdf Download Successful",
                    style: editorStyle(
                        color: Colors.black,
                        weight: FontWeight.bold,
                        size: 20)),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blueGrey.shade50,
                    boxShadow: kButtonShadows),
                child: Shimmer.fromColors(
                    direction: ShimmerDirection.rtl,
                    baseColor: Colors.white,
                    highlightColor: Colors.black54,
                    child: Center(
                        child: Icon(
                      Icons.arrow_circle_left,
                      size: 60,
                    ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
