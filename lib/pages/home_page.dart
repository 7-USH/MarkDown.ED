// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, prefer_final_fields
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:flutter_md/widgets/leftside.dart';
import 'package:flutter_md/widgets/loader.dart';
import 'package:flutter_md/widgets/rightside.dart';
import 'package:window_manager/window_manager.dart';
import 'package:markdown/markdown.dart' as md;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size size = Size(0, 0);
  TextEditingController _controller = TextEditingController();

  getWindowSize() async {
    size = await windowManager.getSize();
    setState(() {});
  }

  @override
  void initState() {
    getWindowSize();
    super.initState();
  }

  String text = "";

  @override
  Widget build(BuildContext context) {
    return size.width == 0
        ? Loader()
        : Scaffold(
            body: Row(children: [
              LeftSide(
                size: size,
                field: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Colors.black,
                  cursorWidth: 1.0,
                  onChanged: (string) {
                    setState(() {
                      text = string;
                    });
                  },
                  autofocus: true,
                  style: editorStyle(
                      color: Colors.black87, weight: FontWeight.w500, size: 18),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start Typing..",
                      hintStyle: editorStyle(
                          color: Colors.black54,
                          weight: FontWeight.normal,
                          size: 20)),
                ),
              ),
              RightSide(
                markdown: Markdown(
                  selectable: true,
                  extensionSet: md.ExtensionSet(
                    md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                    [
                      md.EmojiSyntax(),
                      ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                    ],
                  ),
                  data: text,
                ),
              )
            ]),
          );
  }
}
