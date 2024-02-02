import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_sqflite/screens/edit_notes.dart';
import 'package:to_do_sqflite/sqldb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.selectData("SELECT * FROM notes ");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readData();
    super.initState();
  }

  int oneOrZero(bool value) {
    return value == true ? 1 : 0;
  }

  // bool checkBoxChange(int index) {
  //   return notes[index]['taskCompleted'] == 1 ? true : false;
  // }

  bool isCompeleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text(
            'TO DO',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.yellow[300],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'addnotes');
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: ListView(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Colors.yellow[300],
                        child: ListTile(
                          title: Row(
                            children: [
                              Checkbox(
                                  value: isCompeleted,
                                  onChanged: (newBool) async {
                                    int result = await sqlDb.updateData(''' 
                                    UPDATE notes
                                    SET  taskCompleted= ${oneOrZero(isCompeleted)}
                                      WHERE  id =${notes[index]['id']}; 
                                                                            
                                    ''');

                                    if (result == 1) {
                                      setState(() {});
                                      log(notes[index]['taskCompleted']
                                          .toString());
                                    }
                                    setState(() {});
                                  }),
                              Text(notes[index]['note']),
                            ],
                          ),
                          subtitle: Text(
                            notes[index]['title'],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int response = await sqlDb.DeleteData(
                                      "DELETE FROM NOTES WHERE id= ${notes[index]['id']} ");
                                  if (response > 0) {
                                    notes.removeWhere(
                                      (element) =>
                                          element['id'] == notes[index]['id'],
                                    );
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return EditNote(
                                      note: notes[index]['note'],
                                      tilte: notes[index]['title'],
                                      id: notes[index]['id'],
                                    );
                                  }));
                                },
                                icon: const Icon(
                                  Icons.mode_edit_outline_outlined,
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
              MaterialButton(onPressed: () async {})
            ],
          ),
        ));
  }
}
