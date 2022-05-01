// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

const double VISIBLE_WIDTH = 0;
const double INVISIBLE_WIDTH = -300;

class LeftSide extends StatefulWidget {
  LeftSide(
      {Key? key,
      required this.size,
      required this.whichFile,
      required this.saveChanges,
      required this.field,
      required this.count,
      required this.saveFile,
      required this.openFile})
      : super(key: key);
  Size size;
  int count;
  Widget field;
  String whichFile;
  Function openFile;
  Function saveFile;
  Function saveChanges;

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  bool isTap = false;

  bool isHover1 = false;
  bool isHover2 = false;
  bool isHover3 = false;
  bool isHover4 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width / 2,
      decoration: BoxDecoration(color: scaffoldColor),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Spacer(),
                Text(
                  widget.whichFile,
                  style: editorStyle(
                      color: Colors.white, weight: FontWeight.w500, size: 15),
                ),
                Spacer(),
                Text(
                  widget.count.toString() + " words",
                  style: editorStyle(
                      color: Colors.white, weight: FontWeight.w500, size: 15),
                )
              ]),
              Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                      height: widget.size.height / 1.15,
                      child: SingleChildScrollView(
                          controller: ScrollController(),
                          physics: BouncingScrollPhysics(),
                          child: widget.field))),
            ],
          ),
        ),
        AnimatedPositioned(
          left: isTap ? VISIBLE_WIDTH : INVISIBLE_WIDTH,
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: 300,
            height: widget.size.height,
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
                    onTap: () {
                      widget.openFile();
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
                    onTap: () {
                      widget.saveChanges();
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
                    onTap: () {
                      widget.saveFile();
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
                    onTap: () {},
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
                            Icons.publish,
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
                              "Publish",
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
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  isTap = !isTap;
                });
              },
              child: Icon(
                isTap ? Icons.close : Icons.dashboard,
                color: !isTap ? Colors.white : Colors.black54,
              )),
        ),
      ]),
    );
  }
}
