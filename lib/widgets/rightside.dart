// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:window_manager/window_manager.dart';

class RightSide extends StatefulWidget {
   RightSide({Key? key,required this.markdown}) : super(key: key);
  Widget markdown;

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
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
                    Icon(Icons.preview,size: 18,),
                    SizedBox(width: 15,),
                    Text("Markdown Preview",style: editorStyle(color: Colors.black, weight: FontWeight.w500, size: 15),),
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
          Expanded(child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
              boxShadow: kBoxShadows,
              color: gradColor
            ),
            
            child: widget.markdown))
        ],
      ),
    ));
  }
}
