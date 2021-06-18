import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'course.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(home: semesterBook(), theme: ThemeData.dark()));
  }
}

class semesterBook extends StatefulWidget {
  @override
  _semesterBookState createState() => _semesterBookState();
}

class _semesterBookState extends State<semesterBook> {
  List semesters = [];

  // Fetch content from the json file
  Future<void> loadJSON() async {
    final String response = await rootBundle.loadString('assets/219088.json');
    final data = await json.decode(response);
    setState(() {
      semesters = data["semesters"];
    });
  }

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/mty.jpeg'),
            ),
          ],
          title: Text(
            'Tayyab',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            semesters.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: semesters.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.teal,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) =>
                                        Course(id: semesters[index]["id"]),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                            opacity: anim, child: child),
                                    transitionDuration:
                                        Duration(milliseconds: 300),
                                  ));
                            },
                            leading: Icon(
                              Icons.book_outlined,
                              color: Colors.white,
                            ),
                            title: Text(semesters[index]["name"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                )),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
