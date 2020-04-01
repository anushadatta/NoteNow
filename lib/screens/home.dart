import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'todo.dart';
import 'alarm.dart';
import 'history.dart';
import 'package:NoteTakingApp/screens/add_task.dart';
import 'package:NoteTakingApp/screens/login_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      
      child: Scaffold(
        
        appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            SizedBox(
              height: 20.0,
              width:30.0,
              child: Image.asset('assets/NotesIcon.png'),
            ),
            
            Text('NotesTakingApp'),
          ],
        ),
        
        centerTitle: true,
        
        backgroundColor: Colors.indigo,
        
        leading: Container(),

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              // LOGOUT
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())); 
            },
          )
        ],
      
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.notifications)),
            Tab(icon: Icon(Icons.alarm)),
            Tab(icon: Icon(Icons.history)),
          ],
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            ToDo(),
            Alarm(),
            History(),
          ],
        ),

        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
              );
            }
          ),
      ),
    );
  }
}