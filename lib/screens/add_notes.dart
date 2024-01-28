import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:to_do_sqflite/screens/home.dart';
import 'package:to_do_sqflite/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController tilte = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        centerTitle: true,
        title: const Text('Add Notes'),
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
                        int response = await sqlDb.insertData('''
                          INSERT INTO notes ("note", "title")
                          VALUES  ('${note.text}', '${tilte.text}')
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
