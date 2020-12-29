import 'dart:convert';
import 'dart:collection';

//LinkedHashMap sentenceList = new LinkedHashMap<String, String>();
  var sentenceList = [];

  generateList() {

    // final sentenceList = List<CodeLine>.generate(100, (i) => i % 2 == 0
    //     ? BlueCategory("F","99")
    //     : BlueCategory("+", "45"));

    // var sentenceList = List<CodeLine>.generate(100, (i) => List<CodeLine>(BlueCategory(type, value)));
    // sentenceList.clear();

    for (int i = 0; i < 100; i++) {
      sentenceList.add(["F", "99"]);
      sentenceList.add(["+", "45"]);
    }
    print(sentenceList);
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