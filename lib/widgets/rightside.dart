// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, avoid_unnecessary_containers
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:flutter_md/widgets/leftside.dart';
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
                  icon: Icon(Icons.close))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(child: widget.markdown)
        ],
      ),
    ));
  }
}
