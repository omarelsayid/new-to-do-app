import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_sqflite/screens/home.dart';
import 'package:to_do_sqflite/sqldb.dart';

class EditNote extends StatefulWidget {
  final String note;
  final String tilte;
  final int id;

  const EditNote({
    super.key,
    required this.note,
    required this.tilte,
    required this.id,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController tilte = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    tilte.text = widget.tilte;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        title: const Text(
          'Edit Notes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: note,
                      decoration: const InputDecoration(hintText: 'note'),
                    ),
                    TextFormField(
                      controller: tilte,
                      decoration: const InputDecoration(hintText: 'tilte'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        int response = await sqlDb.updateData('''
                              UPDATE notes 
                              SET note = "${note.text}", title = "${tilte.text}" 
                                WHERE id = ${widget.id}
                                      ''');
                        log('response=================');
                        print(response);
                        if (response > 0) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const Home();
                          }), (route) => false);
                        }
                      },
                      child: const Text('Add Note'),
                      color: Colors.teal[200],
                      textColor: Colors.white,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
