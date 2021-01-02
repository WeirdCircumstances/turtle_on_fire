import 'dart:math';
import 'package:vector_math/vector_math_64.dart' show radians, degrees;

Random rnd = new Random();
var sentenceList = [];
bool oneTimeShot = true;
var state = 0;
double length = 100;
var angle = radians(60);
var iteration = 0;
var tmpIteration;

generateList() {
  // final sentenceList = List<CodeLine>.generate(100, (i) => i % 2 == 0
  //     ? BlueCategory("F","99")
  //     : BlueCategory("+", "45"));

  // var sentenceList = List<CodeLine>.generate(100, (i) => List<CodeLine>(BlueCategory(type, value)));

  print("onetimeshot:");
  print(oneTimeShot);
  if (oneTimeShot) {
    sentenceList.clear();
    print("sentence clear!!");
// F--F--F

    sentenceList.add(["F", length.toString()]);
    sentenceList.add(["-", angle.toString()]);
    sentenceList.add(["-", angle.toString()]);
    sentenceList.add(["F", length.toString()]);
    sentenceList.add(["-", angle.toString()]);
    sentenceList.add(["-", angle.toString()]);
    sentenceList.add(["F", length.toString()]);

    tmpIteration = iteration;
    print("iteration:");
    print(iteration);
    while (tmpIteration > 0) {
      var nextSentence = [];
      for (int i = 0; i < sentenceList.length; i++) {
        var currentEntry = sentenceList.elementAt(i);
        if (currentEntry[0] == "F") {
          // F+F--F+F
          nextSentence.add(["F", length.toString()]);
          nextSentence.add(["+", angle.toString()]);
          nextSentence.add(["F", length.toString()]);
          nextSentence.add(["-", angle.toString()]);
          nextSentence.add(["-", angle.toString()]);
          nextSentence.add(["F", length.toString()]);
          nextSentence.add(["+", angle.toString()]);
          nextSentence.add(["F", length.toString()]);
        } else
          nextSentence.add(currentEntry);
        //print(nextSentence);

        //nextSentence = [];
      }
      // length /= 3.0;
      sentenceList = nextSentence;
      //nextSentence = [];
      tmpIteration--;
    }

    // oneTimeShot = false;
    //return sentenceList;
  }
  return sentenceList;
}
//print(sentenceList[sentenceList.length-2]);
//print(sentenceList[sentenceList.length-1]);

//print("hier");

// for (int i = 0; i < 100; i++) {
//   sentenceList.add(BlueCategory("F", "99"));
//   sentenceList.add(BlueCategory("+", "45"));
// }

// for (int i = 0; i < 100; i++) {
//   sentenceList.add(["F", (50 + rnd.nextInt(100)).toString()]);
//   sentenceList.add(["+", (50 + rnd.nextInt(100)).toString()]);
// }

// sentenceList.add(["F", "10"]);
// sentenceList.add(["+", "2"]);

//sentenceList.add(["+", "45"]);
// //sentenceList.add(["paint", "yellow"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "45"]);
//
// sentenceList.add(["paint", "green"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "45"]);
//
// sentenceList.add(["paint", "black"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "45"]);
//
// sentenceList.add(["paint", "red"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "45"]);
//
// sentenceList.add(["paint", "yellow"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "-45"]);
//
// //sentenceList.add(["paint", "green"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "-45"]);
//
// //sentenceList.add(["paint", "black"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "-45"]);
//
// sentenceList.add(["paint", "red"]);
// sentenceList.add(["F", "100"]);
// sentenceList.add(["+", "-45"]);
// sentenceList.add(["+", "-45"]);
// // sentenceList.add(["paint", "black"]);
// // sentenceList.add(["F", (50 + rnd.nextInt(100)).toString()]);
//  sentenceList.add(["+", (0 + rnd.nextInt(360)).toString()]);
//
// sentenceList.add(["paint", "green"]);
// sentenceList.add(["F", (50 + rnd.nextInt(100)).toString()]);
// sentenceList.add(["+", (0 + rnd.nextInt(360)).toString()]);
//
// sentenceList.add(["paint", "yellow"]);
// sentenceList.add(["F", (50 + rnd.nextInt(100)).toString()]);
// sentenceList.add(["+", (0 + rnd.nextInt(360)).toString()]);
