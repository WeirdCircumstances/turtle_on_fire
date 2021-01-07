// https://www.youtube.com/watch?v=ZtfItHwFlZ8
// Animated List

import 'package:flutter/material.dart';
import 'package:turtle_on_fire/sentence.dart';

class Coder extends StatelessWidget {

  List<CodeLine> sentenceWidgetList = generateWidgetList();
  Coder(this.sentenceWidgetList);

//  marked as immutable, StatefulWidget and the following code should fix that (later)

//   @override
//   _GameWidgetState createState() => _GameWidgetState();
// }
//
// class _GameWidgetState extends State<GameWidget> with TickerProviderStateMixin {
//   Widget build(BuildContext context) {
//     return Center(child: MyPainter());
//   }
// }

  @override
  Widget build(BuildContext context) {
    //final title = 'Coder';
    return MaterialApp(
      //title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //appBar: AppBar(
        //title: Text(title),
        //),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: sentenceWidgetList.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = sentenceWidgetList[index];

            return ListTile(
              // onTap: sentence[index] = "F",
              title: item.buildType(context),
              subtitle: item.buildValue(context),
            );
          },
        ),
      ),
    );
  }
}

generateWidgetList() {
  //if (sentenceList == null) return sentenceList = generateList();

  sentenceList = generateList();

  //sentenceList.entries.map( (entry) => sentenceList(entry.key, entry.value)).toList();

  List<CodeLine> sentenceWidgetList = [];

  for (int i = 0; i < sentenceList.length; i++) {
    var currentEntry = sentenceList.elementAt(i);
    sentenceWidgetList.add(BlueCategory(
        (i + 1).toString() + ". Element: " + currentEntry[0].toString(),
        currentEntry[1].toString()));
  }
  //var current = sentenceList[i];

  //sentenceWidgetList.add(BlueCategory("F", "10"));

  // for (var key in sentenceList) {
  //   sentenceWidgetList.add(BlueCategory(key.toString(), sentenceList[key].toString()));
  // }
  //sentenceList.forEach((k, v) => sentenceWidgetList.add(BlueCategory(k, v)));

  return sentenceWidgetList;
}

abstract class CodeLine {
  /// The title line to show in a list item.
  // final String type;
  // final String value;
  //
  // CodeLine(this.type, this.value);
  //  Widget buildType(BuildContext context) => Text(type);
//
// Widget buildValue(BuildContext context) => Text(value);
  Widget buildType(BuildContext context);

  Widget buildValue(BuildContext context);
}

// class HeadingItem implements CodeLine {
//   final String type;
//
//   HeadingItem(this.type);
//
//   Widget buildType(BuildContext context) {
//     return Text(
//       type,
//       style: Theme.of(context).textTheme.headline5,
//     );
//   }
//
//   Widget buildValue(BuildContext context) => null;
// }

/// A ListItem that contains data to display a message.
class BlueCategory extends CodeLine {
  // evtl final stellen?
  String type;
  String value;

  BlueCategory(this.type, this.value);

  @override
  String toString() {
    return '{$type, $value}';
  }

  Widget buildType(BuildContext context) => Text(type);

  Widget buildValue(BuildContext context) => Text(value);
}
