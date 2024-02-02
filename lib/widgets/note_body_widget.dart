import 'package:flutter/material.dart';

class NoteBodyWidget extends StatelessWidget {
  final Map noteData;

  NoteBodyWidget(this.noteData);

  @override
  Widget build(BuildContext context) {
    // Your existing Card widget code
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.yellow[300],
        child: ListTile(
          title: Row(children: [
            Checkbox(value: false, onChanged: (newBool) async {}),
            Text(noteData['note'])
          ]),
          subtitle: Text(
            noteData['title'],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // IconButtons based on your existing code
            ],
          ),
        ),
      ),
    );
  }
}
