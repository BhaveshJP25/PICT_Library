import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pict_library/services/auth.dart';
import 'package:pict_library/services/note.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  List<Note> _notes = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'https://raw.githubusercontent.com/boriszv/json/master/random_example.json';
    var response = await http.get(url);

    var notes = List<Note>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();


    return MaterialApp(
        home : DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Library App'),
              centerTitle: true,

              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    onPressed: () async {
                      await _auth.signout();
                    },
                    label: Text('Log Out')
                )
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.book)),
                  Tab(icon: Icon(Icons.alarm)),
                  Tab(icon: Icon(Icons.archive)),

                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _notes.length,
                  itemBuilder: (BuildContext context , int index) {
                    return Card(
                      child : Padding(
                        padding: const EdgeInsets.only(top:32,bottom:32,left:16,right:16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _notes[index].title ,
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _notes[index].text,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context , int index) => const Divider(),
                ),
                Icon(Icons.archive),
                Icon(Icons.archive),
              ],
            ),
          ),
        )
    );
  }
}







