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

  Future<List<Map>> fetchData() async {
    return await sqlDb.selectData("SELECT * FROM notes ");
  }

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
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List notes = snapshot.data as List;

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                bool isCompleted = notes[index]['taskCompleted'] == 1;

                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Card(
                    color: Colors.black87,
                    child: Card(
                      color: Colors.yellow.shade300,
                      child: ListTile(
                        title: Row(
                          children: [
                            Checkbox(
                              value: isCompleted,
                              onChanged: (newBool) async {
                                await sqlDb.updateData('''
                            UPDATE notes
                            SET  taskCompleted= ${newBool! ? 1 : 0}
                                  WHERE  id = ${notes[index]['id']}; 
                                ''');

                                setState(() {});
                              },
                            ),
                            notes[index]['taskCompleted'] == 1
                                ? Text(
                                    notes[index]['note'],
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough),
                                  )
                                : Text(notes[index]['note'])
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
                                    "DELETE FROM notes WHERE id= ${notes[index]['id']} ");

                                setState(() {});
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
                                    // Navigate to the edit page with necessary data
                                    return EditNote(
                                      note: notes[index]['note'],
                                      tilte: notes[index]['title'],
                                      id: notes[index]['id'],
                                    );
                                  }),
                                );
                              },
                              icon: const Icon(
                                Icons.mode_edit_outline_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
