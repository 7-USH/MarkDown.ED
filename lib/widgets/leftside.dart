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
      required this.createNewFile,
      required this.color,
      required this.saveFile,
      required this.status,
      required this.downloadAsPDF,
      required this.openFile})
      : super(key: key);
  Size size;
  int count;
  Widget field;
  String whichFile;
  Function openFile;
  Function saveFile;
  Function saveChanges;
  Function createNewFile;
  Function downloadAsPDF;
  Color color;
  String status;

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  

  @override
  Widget build(BuildContext context) {
    print(widget.size.height);

    return Container(
      width: widget.size.width/2,
      decoration: BoxDecoration(color: scaffoldColor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Spacer(),
                  Text(
                    widget.whichFile + widget.status,
                    style: editorStyle(
                        color: widget.color, weight: FontWeight.w500, size: 15),
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
        ),
      ),
    );
  }
}
