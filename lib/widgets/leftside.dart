// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_md/constants/constants.dart';
import 'package:window_manager/window_manager.dart';

const double VISIBLE_WIDTH = 300;
const double INVISIBLE_WIDTH = 00;

class LeftSide extends StatefulWidget {
  LeftSide(
      {Key? key, required this.size, required this.field, required this.count})
      : super(key: key);
  Size size;
  int count;
  Widget field;

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  bool isTap = false;
  TextEditingController _controller = TextEditingController();

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
                  widget.count.toString() + " words",
                  style: editorStyle(
                      color: Colors.white, weight: FontWeight.w500, size: 15),
                )
              ]),
              Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                      height: widget.size.height / 1.15,
                      child: SingleChildScrollView(child: widget.field))),
            ],
          ),
        ),
        AnimatedContainer(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: kButtonShadows),
            height: widget.size.height,
            width: isTap ? VISIBLE_WIDTH : INVISIBLE_WIDTH,
            duration: Duration(milliseconds: 100),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: AnimatedOpacity(
                      opacity: isTap ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                      child: Row(
                        children: [
                          Icon(
                            Icons.file_open,
                            color: Colors.black54,
                            size: 18,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Open file",
                            textAlign: TextAlign.left,
                            style: editorStyle(
                                color: Colors.black54,
                                weight: FontWeight.w500,
                                size: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 30,
                  ),
                  AnimatedOpacity(
                    opacity: isTap ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    child: Row(
                      children: [
                        Icon(
                          Icons.create,
                          color: Colors.black54,
                          size: 18,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Create file",
                          textAlign: TextAlign.left,
                          style: editorStyle(
                              color: Colors.black54,
                              weight: FontWeight.w500,
                              size: 18),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AnimatedOpacity(
                    opacity: isTap ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    child: Row(
                      children: [
                        Icon(
                          Icons.save_as,
                          color: Colors.black54,
                          size: 18,
                        ),
                     SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Save as ",
                          textAlign: TextAlign.left,
                          style: editorStyle(
                              color: Colors.black54,
                              weight: FontWeight.w500,
                              size: 18),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AnimatedOpacity(
                    opacity: isTap ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    child: Row(
                      children: [
                        Icon(
                          Icons.publish,
                          color: Colors.black54,
                          size: 18,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Publish",
                          textAlign: TextAlign.left,
                          style: editorStyle(
                              color: Colors.black54,
                              weight: FontWeight.w500,
                              size: 18),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
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
                color: !isTap ? Colors.white :  Colors.black54,
              )),
        ),
      ]),
    );
  }
}
