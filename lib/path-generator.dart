import 'package:flutter/material.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'package:turtle_on_fire/main.dart';
import 'package:turtle_on_fire/sentence.dart';

Random rnd = new Random();

class PathSentence extends State<MyPainter> {
  bool start = true;
  bool run = false; // Start when programm starts?
  List<Path> pattern = [Path()..moveTo(0, 0)];

  PaintingStyle lineStyle = PaintingStyle.stroke;
  Color colorStyle;
  double widthStyle = 3;
  StrokeCap capStyle = StrokeCap.round;
  List<String> styleList = [];
  var style;
  var value;
  var lengthOfAllVectors = 1.0;
  int speed = 10;
  double size = 100;

  // static Matrix4 matrix4 = Matrix4(
  //     1, 0, 0, 0,
  //     0, 1, 0, 0,
  //     0, 0, 1, 0,
  //     0, 0, 0, 0.5
  // );
  // TransformationController controller = TransformationController(matrix4);
// var paintedList;

// bool firstRun = true;

  //generateList() => paintedList = List<Paint>.generate(this.pattern.length, colorize);

  //SentenceGenerator sentenceList = new SentenceGenerator();

  //PathSentence(this.sentenceList);

  @override
  Widget build(BuildContext context) {
    // if (firstRun) {
    //   sentenceList = generateList();
    //   firstRun = false;
    // }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() {
                  this.run = !this.run;
                  oneTimeShot = true;
                  if (this.run) {
                    sentenceList = generateList();
                    this.pattern = createPattern();
                    iteration++;
                    speed += 10;
                  }
                  //sentenceList = generateList();
                  //print(styleList);
                  //print("Length: " + styleList.length.toString());
                  //print(sentenceList);
                  print(sentenceList.length);
                  //print(iteration);
                  //paintedList = List<Paint>.generate(
                  //    this.pattern.length, colorize);
                }),
            child: Icon((this.run) ? Icons.stop : Icons.play_arrow)),
        body: Center(
          child: InteractiveViewer(
              minScale: 0.0001,
              maxScale: 1000,
              //transformationController: controller,
              child: Transform(
                  transform: Matrix4(
                    1,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                    0,
                    0,
                    0,
                    1,
                  ),
                  alignment: FractionalOffset.center,
                  child: Column(children: <Widget>[
                    (this.start)
                        ? Expanded(
                            child: AnimatedDrawing.paths(
                            this.pattern,
                            paints: List<Paint>.generate(
                                this.pattern.length, colorize),
                            run: this.run,
                            duration: new Duration(
                                milliseconds:
                                    (lengthOfAllVectors / speed).round() * 10),
                            lineAnimation: LineAnimation.oneByOne,
                            //allAtOnce
                            animationCurve: Curves.linear,
                            onFinish: () => setState(() {
                              this.run = false;
                            }),
                            // width: size,
                            //height: size,
                          ))
                        : Container(),
                  ]))),
        ));
  }

  Paint colorize(int index) {
    if (styleList.length > 0) value = styleList[index];

    value ??= "black";
    if (value == "black") colorStyle = Colors.black;
    if (value == "white") colorStyle = Colors.white;
    if (value == "green") colorStyle = Colors.green;
    if (value == "yellow") colorStyle = Colors.yellow;
    if (value == "red") colorStyle = Colors.red;

    return Paint()
      ..style = lineStyle
      ..color = colorStyle
      ..strokeWidth = widthStyle
      ..strokeCap = capStyle;
  }

  List<Path> createPattern() {
    List<Path> paths = List();

    paths.clear();
    styleList.clear();
    lengthOfAllVectors = 0;

    Offset p1 = Offset(0, 0);
    Offset p2 = Offset(0, 1);

    double angle = radians(0);

    Offset newVector;

    // Offset scaleLeftTop = Offset(-100, -100);
    // Offset scaleRightBottom = Offset(100, 100);
    //
    // if (false) {
    //   styleList.add("white");
    //   paths
    //     ..add(Path()
    //       ..moveTo(scaleLeftTop.dx, scaleLeftTop.dy)
    //       ..lineTo(scaleLeftTop.dx + 1, scaleLeftTop.dy + 1)
    //       ..moveTo(scaleRightBottom.dx, scaleRightBottom.dy)
    //       ..lineTo(scaleRightBottom.dx + 1, scaleRightBottom.dy + 1));
    // }

    double oldScale = 1;

    for (int i = 0; i < sentenceList.length; i++) {
      var current = sentenceList.elementAt(i);

      if ((current[0] == "paint") || (current[0] == "size")) {
        style = current[1];

        //print(i.toString() + ".te Zeile");
      }

      if (current[0] == "F") {
        double scale = double.parse(current[1]);

        lengthOfAllVectors += scale;

        // double scale = double.parse(current);
        //count++;
        //styleList = readStylesFromList(styleList, count, paint);
        //print(count);
        //print(styleList);

        styleList.add(style);

        //print("Line: " + count.toString());
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

        angle = radians(180);
        //print(scale);
      }

      if (current[0] == "+") {
        angle = angle + double.parse(current[1]);

        // print("new angle: " + degrees(angle).toString());
        // print("\n");
      }
      if (current[0] == "-") {
        angle -= double.parse(current[1]);
        //print(degrees(angle));

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
