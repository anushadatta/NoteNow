import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:NoteTakingApp/models/task.dart';
import 'package:NoteTakingApp/services/login.dart'; 

class Collections
{ 
  final databaseReference = Firestore.instance;

  String userID = LoginModel.userID;
  String emailID = LoginModel.emailID;

  Future<List<Task>> getNotes() async{

    List<Task> notes = [];
     await databaseReference
        .collection("users").document(userID).collection("Notes")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((d) => 
            notes.add(
            Task(
              tid: d['tid'],
              title: d['title'],
              description: d['description'],
              dateTime: d['dateTime'],
              status: d['status'],
              type: d['type'])
            )     
          ); 
      });
      return notes; 
  }

  addToNotes(Task t) async
  { 
    await databaseReference.collection("users")
        .document(userID).collection("Notes").document(t.tid)
        .setData({
          'tid': t.tid,
          'title': t.title,
          'description': t.description,
          'dateTime': t.dateTime,
          'status': t.status,
          'type': t.type,
      }
    )
    ;
  }

  deleteFromNotes(Task t)
  {
    try {
      databaseReference
          .collection("users")
          .document(userID).collection("Notes").document(t.tid)
          .delete();
    } catch (e) {
      print(e.toString());
      }
  }

  Future<List<Task>> getAlarms() async{

    List<Task> alarms = [];

    await databaseReference
        .collection("users").document(userID).collection("Alarms")
        .getDocuments()
        .then((QuerySnapshot snapshot) {

        snapshot.documents.forEach((a) => 

            alarms.add(
            Task(
              tid: a['tid'],
              title: a['title'],
              description: a['description'],
              dateTime: a['dateTime'],
              status: a['status'],
              type: a['type'],
            )     
          )
        ); 
      }); 
      return alarms; 
  }

  addToAlarms(Task t) async
  {
    await databaseReference.collection("users")
        .document(userID).collection("Alarms").document(t.tid)
        .setData({
          'tid': t.tid,
          'title': t.title,
          'description': t.description,
          'dateTime': t.dateTime,
          'status': t.status,
          'type': t.type,
      }
    );
  }

  deleteFromAlarms(Task t)
  {
    try {
      databaseReference
          .collection("users")
          .document(userID).collection("Alarms").document(t.tid)
          .delete();
    } catch (e) {
      print(e.toString());
      }
  }

  Future<List<Task>> getHistory() async{

    List<Task> history = [];

    await databaseReference
        .collection("users").document(userID).collection("History")
        .getDocuments()
        .then((QuerySnapshot snapshot) {

        snapshot.documents.forEach((n) => 

            history.add(
            Task(
              tid: n['tid'],
              title: n['title'],
              description: n['description'],
              dateTime: n['dateTime'],
              status: n['status'],
              type: n['type'],
            )     
          )
        ); 
      }); 
      return history; 
  }

  addToHistory(Task t) async
  {
    await databaseReference.collection("users")
        .document(userID).collection("History").document(t.tid)
        .setData({
          'tid': t.tid,
          'title': t.title,
          'description': t.description,
          'dateTime': t.dateTime,
          'status': t.status,
          'type': t.type,
      }
    );
  }

  deleteFromHistory(Task t)
  {
    try {
      databaseReference
          .collection("users")
          .document(userID).collection("History").document(t.tid)
          .delete();
    } catch (e) {
      print(e.toString());
      }
  }

  updateNote(Task t) async {
    
     databaseReference
        .collection("users")
        .document(userID).collection("Notes").document(t.tid)
      .updateData({
        'tid': t.title,
          'title': t.title,
          'description': t.description,
          'dateTime': t.dateTime,
          'status': t.status,
          'type': t.type,
      });
  }

  updateHistory(Task t) async {
    databaseReference
        .collection("users")
        .document(userID).collection("History").document(t.tid)
      .updateData({
        'tid': t.title,
          'title': t.title,
          'description': t.description,
          'dateTime': t.dateTime,
          'status': t.status,
          'type': t.type,
      });
  }

  updateAlarm(Task t) async {
    databaseReference
        .collection("users")
        .document(userID).collection("Alarms").document(t.tid)
      .updateData({
        'tid': t.title,
          'title': t.title,
          'description': t.description,
          'dateTime': t.dateTime,
          'status': t.status,
          'type': t.type,
      });
  }

}


