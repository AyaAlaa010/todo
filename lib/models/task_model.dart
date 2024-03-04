class TaskModel{
  String ? id;
  String title;
  String description;
  bool  isDone;
  DateTime dateTime;

  TaskModel({ this.id, required this.title,required this.description,required this.isDone,required this.dateTime});



  factory TaskModel.fromFirestore(Map<String,dynamic> responseMap)=> TaskModel(id:responseMap ["id"],title:responseMap ["title"], description:responseMap[ "description"], isDone: responseMap["isDone"], dateTime:DateTime.fromMicrosecondsSinceEpoch(responseMap["dateTime"]) );


  Map<String ,dynamic> toFirestore()=> {
    "id":id,
    "title":title,
    "description":description,
    "isDone":isDone,
    "dateTime":dateTime.microsecondsSinceEpoch};

}