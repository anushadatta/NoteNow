import 'package:NoteTakingApp/services/collections.dart';
import 'package:flutter/material.dart';
import 'package:NoteTakingApp/models/task.dart';
import 'package:NoteTakingApp/screens/task_card.dart';
import 'package:NoteTakingApp/services/push_notifications.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  
  Future<List<Task>> tasks;

  @override
  Widget build(BuildContext context) {
    return 
      buildNotesList(tasks);
          
  }

Widget buildNotesList(apiData) => FutureBuilder<dynamic> (
  future: apiData,
  builder: (context, snapshot) {

    if (!snapshot.hasData) return Container(

      height: 300,
      width: 400,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Center(
          child: Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.all(5),
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.grey
              ),
            ),
          ),
        )],
      )
    );

    if (snapshot.data.length == 0) {
      return Container(
        height: 300,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
            child: Container(
            height: 200,
            width: 300,
            margin: EdgeInsets.all(5),

            child: Text("Currently you have no notes!", 
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.center),

              ),
            ),
          ],
        )
      );
    }

    return Expanded(

      child: ListView.builder(
        scrollDirection: Axis.vertical,

        itemBuilder: (context, index){

          return TaskCard(t: snapshot.data[index]);

        },

        itemCount: snapshot.data.length),
    );
  }
);

void initState() {

  super.initState();

  setState( () {
    tasks = Collections().getNotes();
    PushNotificationsManager().init();
      }
    );
  }
} 