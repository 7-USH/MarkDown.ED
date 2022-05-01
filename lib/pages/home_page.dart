// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, prefer_final_fields, avoid_unnecessary_containers, unused_field, deprecated_member_use, avoid_print, unused_local_variable, prefer_const_constructors_in_immutables, prefer_is_empty, sized_box_for_whitespace, constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:flutter_md/operations/file_io.dart';
import 'package:flutter_md/widgets/leftside.dart';
import 'package:flutter_md/widgets/loader.dart';
import 'package:flutter_md/widgets/rightside.dart';
import 'package:flutter_md/widgets/timeloader.dart';
import 'package:shimmer/shimmer.dart';
import 'package:window_manager/window_manager.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:path/path.dart';

const double VISIBLE_WIDTH = 0;
const double INVISIBLE_WIDTH = -300;

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
  int initialLength = 0;
  int newLength = 0;
  Color color = Colors.red;
  bool modified = false;
  bool isFileExist = false;

  bool isTap = false;
  bool isHover1 = false;
  bool isHover2 = false;
  bool isHover3 = false;
  bool isHover4 = false;
  bool isHover5 = false;

  List<bool> onTappers = [false, false, false, false, false];

  getWindowSize() async {
    size = await windowManager.getSize();
    setState(() {});
  }

  @override
  void initState() {
    getWindowSize();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return size.width == 0 ? Loader() : homeWidget(context);
  }

  Widget homeWidget(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(children: [
          SizedBox(
            height: double.infinity,
            child: Row(children: [
              Expanded(
                child: LeftSide(
                  whichFile: onWhichFile,
                  status: modified ? " ~ Modified" : "",
                  color: modified ? color : Colors.white,
                  openFile: () async {
                    _controller.text = await fileIO.readFromFile();
                    text = _controller.text;
                    initialLength = text.length;
                    newLength = initialLength;

                    currentFilePath = fileIO.currentFilePath;
                    onWhichFile = basename(currentFilePath);

                    RegExp regExp = RegExp(r"[\w-]+");
                    count = regExp.allMatches(_controller.text).length;
                    setState(() {
                      modified = false;
                    });
                  },
                  createNewFile: () async {
                    String newFileString =
                        await fileIO.saveNewFile(currentFilePath, 'md');
                    newFileString = newFileString + ".md";
                    if (newFileString == "null.md") {
                      print("unable to create");
                    } else {
                      File createFile = File(newFileString);
                      createFile.writeAsString('');
                    }
                  },
                  saveFile: () async {
                    String newFilePath =
                        await fileIO.saveNewFile(currentFilePath, 'md');
                    newFilePath = newFilePath + ".md";

                    if (newFilePath == "null.md") {
                      print("unable to save");
                    } else {
                      File newFile = File(newFilePath);
                      newFile.writeAsString(text);
                    }
                  },
                  saveChanges: () async {
                    await fileIO.saveToFile(text, currentFilePath);
                    initialLength = newLength;
                    modified = false;
                    setState(() {});
                  },
                  downloadAsPDF: () async {
                    if (!modified &&
                        _controller.text.length != 0 &&
                        (currentFilePath != "null.md" &&
                            currentFilePath != null &&
                            currentFilePath != "")) {
                      String htmlCode = md.markdownToHtml(_controller.text);
                      String filePath =
                          await fileIO.savePDF(htmlCode, currentFilePath);
                      isFileExist = await File(filePath).exists();
                      if (isFileExist) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return TimeLoader();
                        }));
                      }
                    }
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
                          newLength = _controller.text.length;
                          if ((newLength != initialLength) &&
                              initialLength != 0) {
                            modified = true;
                          }
                          RegExp regExp = RegExp(r'[\w-]+');
                          count = regExp.allMatches(_controller.text).length;
                        });
                      },
                      autofocus: true,
                      style: editorStyle(
                          color: Colors.white,
                          weight: FontWeight.w500,
                          size: 18),
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
              ),
              Expanded(
                child: RightSide(
                  onFullscreen: () {
                    getWindowSize();
                    setState(() {});
                  },
                  markdown: Markdown(
                    selectable: true,
                    styleSheet: MarkdownStyleSheet(
                        horizontalRuleDecoration:
                            BoxDecoration(color: Colors.black26)),
                    extensionSet: md.ExtensionSet(
                      md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                      [
                        md.EmojiSyntax(),
                        ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                      ],
                    ),
                    data: _controller.text,
                  ),
                ),
              )
            ]),
          ),
          // Scaffold(
          //   backgroundColor: Colors.transparent,
          //   appBar: AppBar(
          //     shadowColor: Colors.transparent,
          //     backgroundColor: Colors.transparent,
          //     foregroundColor: Colors.transparent,
          //     elevation: 0,
          //   ),
          //   drawer: Drawer(
          //     backgroundColor: Colors.transparent,
          //     elevation: 0,
          //     child: Container(decoration: BoxDecoration(
          //       color: Colors.red,
          //       borderRadius: BorderRadius.only(
          //         topRight: Radius.circular(40),
          //         bottomRight: Radius.circular(40))),),
          //   ),
          // )
          AnimatedPositioned(
            left: isTap ? VISIBLE_WIDTH : INVISIBLE_WIDTH,
            duration: const Duration(milliseconds: 100),
            child: Container(
              width: 300,
              height: size.height,
              decoration: BoxDecoration(
                color: gradColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    InkWell(
                      onTap: () async {
                        _controller.text = await fileIO.readFromFile();
                        text = _controller.text;
                        initialLength = text.length;
                        newLength = initialLength;

                        currentFilePath = fileIO.currentFilePath;
                        onWhichFile = basename(currentFilePath);

                        RegExp regExp = RegExp(r"[\w-]+");
                        count = regExp.allMatches(_controller.text).length;
                        setState(() {
                          modified = false;
                        });
                        onTappers[0] = true;
                      },
                      onHover: (value) {
                        setState(() {
                          isHover1 = value;
                        });
                      },
                      child: AnimatedOpacity(
                        opacity: isTap ? 1.0 : 0.0,
                        duration: isTap
                            ? Duration(milliseconds: 500)
                            : Duration(milliseconds: 0),
                        curve: Curves.easeInOut,
                        child: Row(
                          children: [
                            Icon(
                              Icons.file_open,
                              color: !isHover1
                                  ? Color.fromARGB(137, 53, 45, 45)
                                  : Colors.black.withOpacity(0.6),
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Shimmer.fromColors(
                              highlightColor:
                                  isHover1 ? Colors.grey : Colors.black,
                              baseColor: Colors.black,
                              child: Text(
                                "Open File",
                                textAlign: TextAlign.left,
                                style: editorStyle(
                                    color: Colors.black54,
                                    weight: isHover1
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    size: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        String newFileString =
                            await fileIO.saveNewFile(currentFilePath, 'md');
                        newFileString = newFileString + ".md";
                        if (newFileString == "null.md") {
                          print("unable to create");
                        } else {
                          File createFile = File(newFileString);
                          createFile.writeAsString('');
                        }
                      },
                      onHover: (value) {
                        setState(() {
                          isHover5 = value;
                        });
                      },
                      child: AnimatedOpacity(
                        opacity: isTap ? 1.0 : 0.0,
                        duration: isTap
                            ? Duration(milliseconds: 500)
                            : Duration(milliseconds: 0),
                        curve: Curves.easeInOut,
                        child: Row(
                          children: [
                            Icon(
                              Icons.note_add_outlined,
                              color: !isHover5
                                  ? Color.fromARGB(137, 53, 45, 45)
                                  : Colors.black.withOpacity(0.6),
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Shimmer.fromColors(
                              highlightColor:
                                  isHover2 ? Colors.grey : Colors.black,
                              baseColor: Colors.black,
                              child: Text(
                                "Create New File",
                                textAlign: TextAlign.left,
                                style: editorStyle(
                                    color: Colors.black54,
                                    weight: isHover5
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    size: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        await fileIO.saveToFile(text, currentFilePath);
                        initialLength = newLength;
                        modified = false;
                        setState(() {});
                      },
                      onHover: (value) {
                        setState(() {
                          isHover2 = value;
                        });
                      },
                      child: AnimatedOpacity(
                        opacity: isTap ? 1.0 : 0.0,
                        duration: isTap
                            ? Duration(milliseconds: 500)
                            : Duration(milliseconds: 0),
                        curve: Curves.easeInOut,
                        child: Row(
                          children: [
                            Icon(
                              Icons.create,
                              color: !isHover2
                                  ? Color.fromARGB(137, 53, 45, 45)
                                  : Colors.black.withOpacity(0.6),
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Shimmer.fromColors(
                              highlightColor:
                                  isHover2 ? Colors.grey : Colors.black,
                              baseColor: Colors.black,
                              child: Text(
                                "Save Changes",
                                textAlign: TextAlign.left,
                                style: editorStyle(
                                    color: Colors.black54,
                                    weight: isHover2
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    size: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        String newFilePath =
                            await fileIO.saveNewFile(currentFilePath, 'md');
                        newFilePath = newFilePath + ".md";

                        if (newFilePath == "null.md") {
                          print("unable to save");
                        } else {
                          File newFile = File(newFilePath);
                          newFile.writeAsString(text);
                        }
                      },
                      onHover: (value) {
                        setState(() {
                          isHover3 = value;
                        });
                      },
                      child: AnimatedOpacity(
                        opacity: isTap ? 1.0 : 0.0,
                        duration: isTap
                            ? Duration(milliseconds: 500)
                            : Duration(milliseconds: 0),
                        curve: Curves.easeInOut,
                        child: Row(
                          children: [
                            Icon(
                              Icons.save_as,
                              color: !isHover3
                                  ? Color.fromARGB(137, 53, 45, 45)
                                  : Colors.black.withOpacity(0.6),
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Shimmer.fromColors(
                              highlightColor:
                                  isHover3 ? Colors.grey : Colors.black,
                              baseColor: Colors.black,
                              child: Text(
                                "Save as New File",
                                textAlign: TextAlign.left,
                                style: editorStyle(
                                    color: Colors.black54,
                                    weight: isHover3
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    size: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        if (!modified &&
                            _controller.text.length != 0 &&
                            (currentFilePath != "null.md" &&
                                currentFilePath != null &&
                                currentFilePath != "")) {
                          String htmlCode = md.markdownToHtml(_controller.text);
                          String filePath =
                              await fileIO.savePDF(htmlCode, currentFilePath);
                          isFileExist = await File(filePath).exists();
                          if (isFileExist) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return TimeLoader();
                            }));
                          }
                        }
                      },
                      onHover: (value) {
                        setState(() {
                          isHover4 = value;
                        });
                      },
                      child: AnimatedOpacity(
                        opacity: isTap ? 1.0 : 0.0,
                        duration: isTap
                            ? Duration(milliseconds: 500)
                            : Duration(milliseconds: 0),
                        curve: Curves.easeInOut,
                        child: Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf,
                              color: !isHover4
                                  ? Color.fromARGB(137, 53, 45, 45)
                                  : Colors.black.withOpacity(0.6),
                              size: 18,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Shimmer.fromColors(
                              highlightColor:
                                  isHover4 ? Colors.grey : Colors.black,
                              baseColor: Colors.black,
                              child: Text(
                                "Download as PDF",
                                textAlign: TextAlign.left,
                                style: editorStyle(
                                    color: Colors.black54,
                                    weight: isHover4
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    size: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    getWindowSize();
                    setState(() {
                      isTap = !isTap;
                    });
                  },
                  child: Icon(
                    isTap ? Icons.close : Icons.dashboard,
                    color: !isTap ? Colors.white : Colors.black54,
                  )))
        ]),
      ),
    );
  }
}
