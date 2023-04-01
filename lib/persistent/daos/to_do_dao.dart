import 'package:to_do_app/data/vos/to_do_vo.dart';

abstract class ToDoDAO{
  void toDoListToBox(List<ToDoVo>toDoItem);

  void toDoItemToBox(ToDoVo toDoItem);

  List<ToDoVo> ? toDoListFromBox();

  ToDoVo ? todoItemFromBox(int id);

  void createToDoItem(String title,String context,String ? note,String ? date,String ? time,ToDoVo? toEdit);

  void deleteToDoItemFromBox(int id);


  Stream watchBox();

  Stream<List<ToDoVo>?> toDoListFromBoxAsStream();

}