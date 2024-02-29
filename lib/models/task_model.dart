class TaskModel{
  String ? id;
  String title;
  String description;
  bool  isDone;
  DateTime dateTime;

  TaskModel({ this.id, required this.title,required this.description,required this.isDone,required this.dateTime});



  factory TaskModel.fromFirestore(Map<String,dynamic> responseMap)=> TaskModel(title:responseMap ["title"], description:responseMap[ "description"], isDone: responseMap["isDone"], dateTime: responseMap["dateTime"]);


  Map<String ,dynamic> toFirestore()=> {
    "title":title,
    "description":description,
    "isDone":isDone,
    "dateTime":dateTime};

}