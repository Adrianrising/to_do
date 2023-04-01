import 'package:stream_transform/stream_transform.dart';
import 'package:to_do_app/data/data_apply/to_do_apply.dart';
import 'package:to_do_app/data/vos/to_do_vo.dart';
import 'package:to_do_app/persistent/daos/to_do_dao.dart';
import 'package:to_do_app/persistent/daos/to_do_dao_impl.dart';

class ToDoApplyImpl extends ToDoApply {
  ToDoApplyImpl._();

  static final _singleton = ToDoApplyImpl._();

  factory ToDoApplyImpl() => _singleton;

  final ToDoDAO _toDoDAO = ToDoDAOImpl();

  @override
  void toDoListToBox(List<ToDoVo> toDoItem) => _toDoDAO.toDoListToBox(toDoItem);

  @override
  Stream<List<ToDoVo>?> toDoListFromBoxAsStream() => _toDoDAO
      .watchBox()
      .startWith(_toDoDAO.toDoListFromBoxAsStream())
      .map((event) => _toDoDAO.toDoListFromBox());

  @override
  void toDoItemToBox(ToDoVo toDoItem) => _toDoDAO.toDoItemToBox(toDoItem);

  @override
  void createToDoItem(String title,String context,String ? note,String ? date,String ? time,ToDoVo? toEdit)=>
      _toDoDAO.createToDoItem(title, context, note, date, time,toEdit);

  @override
  ToDoVo? todoItemFromBox(int id)=>_toDoDAO.todoItemFromBox(id);

  @override
  void deleteToDoItemFromBox(int id)=>_toDoDAO.deleteToDoItemFromBox(id);
}
