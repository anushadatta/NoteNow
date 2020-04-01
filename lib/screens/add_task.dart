import 'package:flutter/material.dart';

import 'package:NoteTakingApp/models/task.dart';
import 'add_task_note.dart';
import 'add_task_alarm.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  // Note or Alarm Initialisation
  String dropdownValue = 'NOTE';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
              width: 30.0,
              child: Image.asset('assets/NotesIcon.png'),
            ),
            Text("ADD TASK"),
          ],
        ),
        centerTitle: true,
      ),
      
      body: 
          // CHECK NOTE or ALARM
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: <Widget>[ 

                Text("SELECT TASK TYPE",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), 
                
                ),

                SizedBox(height: 30.0),

                DropdownButton<String>(
                  value: dropdownValue,
                  icon:
                    Icon(Icons.arrow_drop_down, size: 50),
                  iconSize: 30,
                  elevation: 26,
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  underline: Container(
                    height: 8,
                    width: 20,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['NOTE', 'ALARM']
                      .map<DropdownMenuItem<String>>(
                          (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          textAlign: TextAlign.center),
                    );
                  }).toList(),
                ),
                
                //NEXT BUTTON 
                SizedBox(
                width: 305.0,
                height: 72.0, 
                child: Padding(
                padding: const EdgeInsets.all(12.0),

                child: RaisedButton(
                  disabledColor: Colors.grey[250],
                  splashColor: Colors.black87,
                  
                  // Creating Note/Alarm
                  onPressed: 
                  () {
                    if(dropdownValue == 'NOTE')
                    {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNote()),
                      );
                    }
                    else
                    {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddAlarm()),
                      );
                    }
                  }, 

                  child: Text('NEXT',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ),
            )
        ],
      ),
    ),
    );
  }
}