// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, prefer_final_fields, avoid_unnecessary_containers, unused_field, deprecated_member_use, avoid_print
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
  int count = 0;
  String text = "";

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
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (_) {
    //     return homeWidget();
    //   }));
    // });
    return size.width==0 ? Loader() : homeWidget();
  }

  Scaffold homeWidget() {
    return Scaffold(
      body: Row(children: [
        LeftSide(
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
                  text = string;
                  RegExp regExp = RegExp(' ');
                  count = regExp.allMatches(text).length;
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
            data: text,
          ),
        )
      ]),
    );
  }
}
