import 'package:NoteTakingApp/screens/home.dart';
import 'package:NoteTakingApp/services/collections.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:NoteTakingApp/models/task.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
 
  final formKey = GlobalKey<FormState>();

  String _title;
  String _description;

  // Note or Alarm Initialisation
  String dropdownValue = 'NOTE';
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
            Text("ADD NOTE"),
          ],
        ),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(20), 
        
        child: Form(
          key: formKey,
          
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
              
              SizedBox(height: 20), 
              
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
                            tid: _depDateTime.toString(),
                            title: _title, 
                            description: _description, 
                            type: dropdownValue == 'NOTE' ? false : true,
                            dateTime: _depDateTime.toString(), 
                            status: false); 
                         
                          Collections().addToNotes(t); 

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
    );
  }
}