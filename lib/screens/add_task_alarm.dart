import 'package:NoteTakingApp/screens/home.dart';
import 'package:NoteTakingApp/services/collections.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:NoteTakingApp/models/task.dart';

class AddAlarm extends StatefulWidget {
  @override
  _AddAlarmState createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
 final formKey = GlobalKey<FormState>();

  String _title;
  String _description;

  // Note or Alarm Initialisation
  String dropdownValue = 'ALARM';
  DateTime _depDateTime = DateTime.now();

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
            Text("ADD ALARM"),
          ],
        ),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: //EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 100.0),
        EdgeInsets.all(20), 
        
        child: Form(
          key: formKey,
          
          child: Center(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                
                // Title
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Title:'),
                  validator: (input) =>
                      input == '' ? 'Please enter a title' : null,
                  onSaved: (input) => _title = input,
                ),

                // DESCRIPTION
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Description'),
                  validator: (input) => input == ''
                      ? 'Please enter a description'
                      : null,
                  onSaved: (input) => _description = input,
                  //obscureText: true,
                ), 

                SizedBox(height: 40), 

                // DATE PICKER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[  

                    Container(
                      child: Center(
                          child: Text(
                              //_depDateTime.toIso8601String(),
                              _depDateTime == null
                                  ? '___________________'
                                  : DateFormat.yMMMd()
                                      .format(_depDateTime).toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ))),
                      color: Colors.grey[200],
                      width: 250.0,
                      height: 50.0,
                      //margin: const EdgeInsets.all(5.0),
                    ),

                    IconButton(
                      icon:
                        Icon(Icons.arrow_drop_down, size: 40),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate:
                                    _depDateTime == null
                                        ? DateTime.now()
                                        : _depDateTime,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2022))
                            .then((date) {
                          setState(() {
                            _depDateTime = date;
                          });
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(height:20), 

                //ADD button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    SizedBox(
                      width: 305.0,
                      height: 72.0, 
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),

                        child: RaisedButton(
                          disabledColor: Colors.grey[250],
                          splashColor: Colors.black87,
                          
                          // ADDING TASK TO NOTES/ALARM
                          // (_title, _description, _depDateTime ,dropdownValue)
                          onPressed: 
                          () {
                            if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            
                            var t = Task(
                              tid: _title, 
                              title: _title, 
                              description: _description, 
                              type: dropdownValue == 'NOTE' ? false : true,
                              dateTime: _depDateTime.toString(), 
                              status: false); 
                              
                            Collections().addToAlarms(t); 

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage())); 
                            } 
                          }, 

                          child: Text('ADD',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}