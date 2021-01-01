import 'dart:math';

Random rnd = new Random();

//LinkedHashMap sentenceList = new LinkedHashMap<String, String>();
var sentenceList = [];
bool oneTimeShot = true;

generateList() {
  // final sentenceList = List<CodeLine>.generate(100, (i) => i % 2 == 0
  //     ? BlueCategory("F","99")
  //     : BlueCategory("+", "45"));

  // var sentenceList = List<CodeLine>.generate(100, (i) => List<CodeLine>(BlueCategory(type, value)));

  if (oneTimeShot) {
    sentenceList.clear();

    for (int i = 0; i <= 2000; i++) {
      sentenceList.add(["F", (50 + rnd.nextInt(100)).toString()]);
      sentenceList.add(["paint", "black"]);
      sentenceList.add(["+", (0 + rnd.nextInt(180)).toString()]);
      sentenceList.add(["paint", "green"]);
      sentenceList.add(["F", (50 + rnd.nextInt(100)).toString()]);
      sentenceList.add(["paint", "yellow"]);
      sentenceList.add(["+", (0 + rnd.nextInt(180)).toString()]);
    }
    oneTimeShot = false;
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
  return sentenceList;
}