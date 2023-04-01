import 'package:hive/hive.dart';
import 'package:to_do_app/data/vos/to_do_vo.dart';
import 'package:to_do_app/persistent/daos/to_do_dao.dart';

import '../../constant/hive_constant.dart';

import 'dart:math';

class ToDoDAOImpl extends ToDoDAO{
  ToDoDAOImpl._();
  static final _singleton=ToDoDAOImpl._();
  factory ToDoDAOImpl()=>_singleton;

  Set<int> usedKeys = {}; // set to store used keys

  Box<ToDoVo> _getToDoBox()=>Hive.box<ToDoVo>(kToDoBoxName);

  @override
  List<ToDoVo>? toDoListFromBox()=>_getToDoBox().values.toList();


  @override
  void toDoListToBox(List<ToDoVo> toDoItem) {
    toDoItem.forEach((element) {
      element.id=DateTime.now().microsecondsSinceEpoch;
      _getToDoBox().put(element.id, element);
    });
  }

  @override
  Stream watchBox()=>_getToDoBox().watch();

  @override
  Stream<List<ToDoVo>?> toDoListFromBoxAsStream()=>Stream.value(toDoListFromBox());

  @override
  void toDoItemToBox(ToDoVo toDoItem) {
    _getToDoBox().put(toDoItem.id, toDoItem);
  }

  @override
  void createToDoItem(String title, String context, String? note,String ? date,String ? time,ToDoVo? toEdit) {
    if(toEdit==null){
      ToDoVo todoItem=ToDoVo(generateUniqueKey(), title, context, note,date,time);
      toDoItemToBox(todoItem);
    }else{
      final temp=_getToDoBox().get(toEdit.id);
      temp?.title=title;
      temp?.context=context;
      temp?.note=note;
      temp?.date=date;
      temp?.time=time;
      _getToDoBox().put(toEdit.id, temp!);
    }
  }

  int generateUniqueKey() {
    int key = Random().nextInt(0xFFFFFFFF);
    while (usedKeys.contains(key)) {
      key = Random().nextInt(0xFFFFFFFF);
    }
    usedKeys.add(key);
    return key;
  }

  @override
  ToDoVo? todoItemFromBox(int id) {
    return _getToDoBox().get(id);
  }

  @override
  void deleteToDoItemFromBox(int id){
    _getToDoBox().delete(id);
  }

}