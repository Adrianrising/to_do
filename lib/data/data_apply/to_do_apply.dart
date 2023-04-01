import '../vos/to_do_vo.dart';

abstract class ToDoApply{
  void toDoListToBox(List<ToDoVo> toDoItem);
  void toDoItemToBox(ToDoVo toDoItem);
  void createToDoItem(String title,String context,String ? note,String ? date,String ? time,ToDoVo? toEdit);
  ToDoVo ? todoItemFromBox(int id);
  void deleteToDoItemFromBox(int id);
  Stream<List<ToDoVo>?> toDoListFromBoxAsStream();
}