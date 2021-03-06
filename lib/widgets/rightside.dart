// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:window_manager/window_manager.dart';

class RightSide extends StatefulWidget {
  RightSide(
      {Key? key,
      required this.markdown,
      required this.onFullscreen,
      required this.isDownloading})
      : super(key: key);
  Widget markdown;
  Function onFullscreen;
  bool isDownloading;

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: gradColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.preview,
                      size: 18,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Markdown Preview",
                      style: editorStyle(
                          color: Colors.black,
                          weight: FontWeight.w500,
                          size: 15),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    widget.isDownloading ?
                    Row(
                      children: [
                        Text(
                          "Downloading",
                          style: editorStyle(
                              color: Colors.red,
                              weight: FontWeight.w500,
                              size: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.red, size: 17),
                      ],
                    ) : Text(""),
                  ],
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                  onPressed: () async {
                    if (!isFull) {
                      await DesktopWindow.setFullScreen(true);
                      isFull = true;
                    } else {
                      await DesktopWindow.setFullScreen(false);
                      isFull = false;
                    }
                    widget.onFullscreen();
                    setState(() {});
                  },
                  icon:
                      Icon(isFull ? Icons.fullscreen_exit : Icons.fullscreen)),
              IconButton(
                  onPressed: () async {
                    await windowManager.minimize();
                  },
                  icon: Icon(Icons.horizontal_rule)),
              IconButton(
                  onPressed: () async {
                    await windowManager.close();
                  },
                  icon: Icon(Icons.close)),
            ],
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: kBoxShadows,
                      color: gradColor),
                  child: widget.markdown))
        ],
      ),
    );
  }
}
