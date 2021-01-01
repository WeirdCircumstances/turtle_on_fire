import 'package:flutter/material.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'package:turtle_on_fire/main.dart';
import 'package:turtle_on_fire/sentence.dart';

Random rnd = new Random();

class PathSentence extends State<MyPainter> {
  bool start = true;
  bool run = false;
  List<Path> pattern = [Path()..moveTo(0, 0)];

  PaintingStyle lineStyle = PaintingStyle.stroke;
  var colorStyle = Colors.black;
  double widthStyle = 1;
  StrokeCap capStyle = StrokeCap.round;
  var styleList = List(100);

  //SentenceGenerator sentenceList = new SentenceGenerator();

  //PathSentence(this.sentenceList);

  @override
  Widget build(BuildContext context) {
    //this.pattern = createPattern();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            oneTimeShot = true;
                this.pattern = createPattern();
                this.run = !this.run;
                this.run ? null : sentenceList = generateList();
              }),
          child: Icon((this.run) ? Icons.stop : Icons.play_arrow)),
      body: Center(
          child: Column(children: <Widget>[
        (this.start)
            ? Expanded(
                child: AnimatedDrawing.paths(
                  this.pattern,
                paints: List<Paint>.generate(this.pattern.length, colorize),
                //paints: List<Paint>.generate(this.pattern.length, null),
                run: this.run,
                duration: new Duration(seconds: 60),
                lineAnimation: LineAnimation.oneByOne,
                animationCurve: Curves.linear,
                onFinish: () => setState(() {
                  this.run = false;
                }),
              ))
            : Container(),
      ])),
    );
  }

  Paint colorize(int index) {
    //var current = styleList.elementAt(index);
    //if (current[0] == index) print("Current line" + index.toString());//colorStyle = current[1];

    // print("++++++++++++++++++++++++++++++++++");
    // print("Following must match:");
    // //print("Current:                " + current.toString());
    // print("Current StyleList Item: " + styleList.toString());
    // print("Color:                  " + colorStyle.toString());
    // print("All the Stuff:          " + styleList.toString());
    // print("Current Index:          " + index.toString());

    return Paint()
      ..style = lineStyle
      ..color = colorStyle
      ..strokeWidth = widthStyle
      ..strokeCap = capStyle;
  }

  List<Path> createPattern() {
    List<Path> paths = List();

    paths.clear();

    Offset p1 = Offset(0, 0);
    Offset p2 = Offset(0, 1);

    double angle = 0;

    Offset newVector;

    // Offset scaleLeftTop = Offset(-100, -100);
    // Offset scaleRightBottom = Offset(100, 100);
    //
    // paths
    //   ..add(Path()
    //     ..moveTo(scaleLeftTop.dx, scaleLeftTop.dy)
    //     ..lineTo(scaleLeftTop.dx + 1, scaleLeftTop.dy + 1)
    //     ..moveTo(scaleRightBottom.dx, scaleRightBottom.dy)
    //     ..lineTo(scaleRightBottom.dx + 1, scaleRightBottom.dy + 1));

    // var sentenceList = List.generate(1, (i) => List(2), growable: true);

    // sentenceList.clear();

    // for (int i = 0; i < 10; i++) {
    //   sentenceList.add(["F", (50 + rnd.nextInt(100)).toString()]);
    //   sentenceList.add(["+", (50 + rnd.nextInt(100)).toString()]);
    // }

    // List<CodeLine> sentenceList = generateList();

    // final List<CodeLine> sentenceList = [];
    //
    // for (int i = 0; i < 100; i++) {
    //   sentenceList.add(BlueCategory("F", "99"));
    //   sentenceList.add(BlueCategory("+", "45"));
    // }

    //var sentenceList = generateList();

    //print("List length: " + sentenceList.length.toString());

    double oldScale = 1;

    for (int i = 0; i < sentenceList.length; i++) {
      var current = sentenceList.elementAt(i);

      if (current[0] == "paint") {
        //styleList = readStylesFromList(styleList, i, current[1]);
        //print(i.toString() + ".te Zeile");
      }

      if (current[0] == "F") {
        double scale = double.parse(current[1]);
        // double scale = double.parse(current);

        //p2 = Offset(0, double.parse(current[1]) * newVector.dx);
        // p2 = p2.dx * newVector.dx;
        //
        // print("Before p1: " + i.toString() + " " + p1.toString());
        // print("Before p2: " + i.toString() + " " + p2.toString());
        //
        // print("F:         " +
        //     scale.toString() +
        //     " " +
        //     counter.toString() +
        //     ". Linie");
        // //print("angle:     " + degrees(angle).toString());
        // print("scale:     " + scale.toString());
        // print("oldScale:  " + oldScale.toString());
        // counter++;

        newVector = locationVector(p1, p2);
        // angle == 0 ? newVector = locationVector(p1, p2) : newVector = p2;
        newVector = scaleVector(newVector, oldScale, false);
        newVector = scaleVector(newVector, scale, true);

        newVector = turnVector(newVector, angle);
        newVector = translateVector(newVector, p2);

        oldScale = scale;

        p1 = p2;
        p2 = newVector;

        paths
          ..add(Path()
            ..moveTo(p1.dx, p1.dy)
            ..lineTo(p2.dx, p2.dy));

        angle = 0;
      }

      if (current[0] == "+") {
        // if (current == "+") {
        angle = angle + radians(double.parse(current[1]));

        // print("new angle: " + degrees(angle).toString());
        // print("\n");
      }
      //
      // newVector = locationVector(p1, p2);
      // newVector = scaleVector(newVector, oldScale, false);
      // newVector = scaleVector(newVector, scale, true);
      // newVector = turnVector(newVector, angle);
      // newVector = translateVector(newVector, p2);
      //
      // oldScale = scale;
      //
      // paths
      //   ..add(Path()
      //     ..moveTo(p1.dx, p1.dy)
      //     ..lineTo(p2.dx, p2.dy));
      //
      // // print(newVector);
      // // newVector = vector(p1, newVector);
      // // newVector = newVector * 0.5;
      // // newVector = translateVector(newVector, p2);
      // // print(newVector);
      // // newVector = scaleVector(newVector, 1.1, false);
      // // angle = angle - radians(1);
      //
      // p1 = p2;
      // p2 = newVector;
    }
    // if (paths.isEmpty) return paths..add(Path()..moveTo(0, 0));

    //print("Path length: " + paths.length.toString());
    //print(paths);
    return paths;
  }
}

locationVector(Offset p1, Offset p2) {
  //shift to origin
  vectorX(p1, p2) {
    double x = p1.dx - p2.dx;
    return x;
  }

  vectorY(p1, p2) {
    double y = p1.dy - p2.dy;
    return y;
  }

  return Offset(vectorX(p1, p2), vectorY(p1, p2));
}

turnVector(Offset locationVector, double angle) {
  rotateX(locationVector, angle) {
    return (locationVector.dx * cos(angle) - locationVector.dy * sin(angle));
  }

  rotateY(vector, angle) {
    return (vector.dx * sin(angle) + vector.dy * cos(angle));
  }

  return Offset(rotateX(locationVector, angle), rotateY(locationVector, angle));
}

translateVector(Offset turnedVector, Offset point) {
  return Offset(turnedVector.dx + point.dx, turnedVector.dy + point.dy);
}

scaleVector(Offset vector, double scale, bool up) {
  if (up) return vector * scale;
  return vector / scale;
}

// class StyleList {
//   int index;
//   var value;
//
//   StyleList(this.index, this.value);
// }

readStylesFromList(List styleList, int index, String colorStyle) {
  /*
  PaintingStyle lineStyle = PaintingStyle.stroke;
  var colorStyle = Colors.black;
  double widthStyle = 1;
  StrokeCap capStyle = StrokeCap.round;*/

  if (colorStyle == "black") styleList[index] = Color(0xff000000);
  if (colorStyle == "yellow") styleList[index] = Color(0xffffeb3b);
  if (colorStyle == "green") styleList[index] = Color(0xff4caf50);

  return styleList;
}
