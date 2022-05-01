// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, prefer_final_fields, avoid_unnecessary_containers, unused_field, deprecated_member_use, avoid_print, unused_local_variable, prefer_const_constructors_in_immutables
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:flutter_md/operations/file_io.dart';
import 'package:flutter_md/widgets/leftside.dart';
import 'package:flutter_md/widgets/loader.dart';
import 'package:flutter_md/widgets/rightside.dart';
import 'package:window_manager/window_manager.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size size = Size(0, 0);
  TextEditingController _controller = TextEditingController();
  int count = 0;
  String text = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  FileIO fileIO = FileIO();
  String currentFilePath = "";
  String onWhichFile = "";

  getWindowSize() async {
    size = await windowManager.getSize();
    setState(() {});
  }

  @override
  void initState() {
    getWindowSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return size.width == 0 ? Loader() : homeWidget();
  }

  Scaffold homeWidget() {
    return Scaffold(
      body: Row(children: [
        LeftSide(
          whichFile: onWhichFile,
          openFile: () async {
            _controller.text = await fileIO.readFromFile();
            text = _controller.text;

            currentFilePath = fileIO.currentFilePath;
            onWhichFile = basename(currentFilePath);

            RegExp regExp = RegExp(r"[\w-]+");
            count = regExp.allMatches(_controller.text).length;
            setState(() {});
          },
          saveFile: () async {
            String newFilePath = await fileIO.saveNewFile(currentFilePath);
            newFilePath = newFilePath + ".md";

            if (newFilePath == "null.md") {
              print("unable to save");
            } else {
              File newFile = File(newFilePath);
              newFile.writeAsString(text);
            }
          },
          saveChanges: () async {
            await fileIO.saveToFile(text,currentFilePath);
          },
          size: size,
          count: count,
          field: Theme(
            data: ThemeData(textSelectionColor: Colors.white),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: Colors.white54,
              cursorWidth: 1.5,
              onChanged: (string) {
                setState(() {
                  text = _controller.text;
                  RegExp regExp = RegExp(r'[\w-]+');
                  count = regExp.allMatches(_controller.text).length;
                });
              },
              autofocus: true,
              style: editorStyle(
                  color: Colors.white, weight: FontWeight.w500, size: 18),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Start Typing..",
                  hintStyle: editorStyle(
                      color: Colors.white,
                      weight: FontWeight.normal,
                      size: 20)),
            ),
          ),
        ),
        RightSide(
          markdown: Markdown(
            selectable: true,
            styleSheet: MarkdownStyleSheet(
                horizontalRuleDecoration: BoxDecoration(color: Colors.black26)),
            extensionSet: md.ExtensionSet(
              md.ExtensionSet.gitHubFlavored.blockSyntaxes,
              [
                md.EmojiSyntax(),
                ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
              ],
            ),
            data: _controller.text,
          ),
        )
      ]),
    );
  }
}
