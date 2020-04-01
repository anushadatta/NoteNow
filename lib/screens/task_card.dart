import 'package:NoteTakingApp/services/collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:NoteTakingApp/models/task.dart';
import 'edit_note.dart';
import 'edit_alarm.dart'; 
import 'edit_history.dart'; 

class TaskCard extends StatefulWidget {
  @override
  Task t;
  TaskCard({this.t});

  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  
  @override
  Widget build(BuildContext context) {
    
    // Initialising favourite button for error handling
    if (widget.t.status == null) 
      widget.t.status = false;

    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Completion status radio button
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Ink(
                        width: 30.0,
                        height: 30.0,
                        child: IconButton(
                          icon: widget.t.status
                              ? Icon(Icons.radio_button_checked)
                              : Icon(Icons.radio_button_unchecked),
                          color: Colors.purple,
                          iconSize: 30.0,
                          onPressed: () {
                            setState(() {

                              // Complete to Incomplete
                              if (widget.t.status == true) {
                                widget.t.status = false;
                                
                                 // NOTE
                                if(widget.t.type == false)
                                {
                                  Collections().deleteFromHistory(widget.t);
                                  Collections().addToNotes(widget.t);
                                }
                                // ALARM
                                else
                                {
                                  Collections().deleteFromHistory(widget.t);
                                  Collections().addToAlarms(widget.t);
                                }

                              } 
                              
                              // Incomplete to complete 
                              else {
                                widget.t.status = true;
                                
                                // NOTE
                                if(widget.t.type == false)
                                {

                                  Collections().addToHistory(widget.t);
                                  Collections().deleteFromNotes(widget.t);
                                  
                                }
                                // ALARM
                                else
                                {
                                  Collections().addToHistory(widget.t);
                                  Collections().deleteFromAlarms(widget.t);
                                  
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Task information (Title, Description, Date/Deadline)

                Expanded(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: Text(
                            widget.t.title,
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 7.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Center(
                          child: Text(
                            widget.t.description,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 3.0),
                      
                      Center(
                        child: Text(
                          widget.t.dateTime.toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                  // Edit button
                  ClipOval(
                    child: Material(
                      color: Colors.grey[100], // button color
                      child: InkWell(
                        splashColor: Colors.black87, // inkwell color
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.edit, color: Colors.purple)),
                        onTap: () {
                        
                        
                          // NOTE
                          if(widget.t.type == false)
                          { 
                            if(widget.t.status == false)
                                //Collections().deleteFromNotes(widget.t);
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditNote(t: widget.t)),
                                );
                                
                            else
                              // Collections().deleteFromHistory(widget.t);
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditHistory(t: widget.t, check: false)),
                              );
                          }
                          // ALARM
                          else
                          {
                            if(widget.t.status== false)
                              //Collections().deleteFromAlarms(widget.t);
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditAlarm(t: widget.t)),
                              );
                                
                            else
                              //Collections().deleteFromHistory(widget.t);
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditHistory(t: widget.t, check: true)),
                              );  
                          }
                        },
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(right: 50.0)),

                  // DELETE BUTTON
                  ClipOval(
                    child: Material(
                      color: Colors.grey[100], // button color
                      child: InkWell(
                        splashColor: Colors.black87, // inkwell color
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.delete, color: Colors.purple)),
                        
                        onTap: () {

                          showDialog(context: context,
                          builder: (_) => 
                          AlertDialog(
                          title: Text("DELETE TASK"),
                          content: Text("Are you sure you want to delete?"),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            FlatButton(
                              child: Text("YES"),
                              onPressed: () {

                                setState(() {
                                
                                // NOTE
                                if(widget.t.type == false)
                                { 
                                  if(widget.t.status == false)
                                      Collections().deleteFromNotes(widget.t);

                                  else
                                    Collections().deleteFromHistory(widget.t);
                                }

                                // ALARM
                                else
                                {
                                  if(widget.t.status== false)
                                    Collections().deleteFromAlarms(widget.t);
                                  else
                                    Collections().deleteFromHistory(widget.t);
                                }

                                Navigator.of(context).pop();
                                                                  
                               });
                               
                              },
                            ),

                             FlatButton(
                              child: Text("CANCEL"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                         )
                        );   
                       },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
