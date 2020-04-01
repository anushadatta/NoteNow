class Task
{ 
  String tid;
  String title; 
  String description; 
  String dateTime;  
  bool status;          // Date of creation/modification for note or Alarm date 
  bool type;            // Note or Alarm

  Task({
    this.tid,
    this.title,
    this.description,
    this.dateTime,
    this.status,
    this.type,
  });
  
}