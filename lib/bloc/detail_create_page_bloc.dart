import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_app/data/vos/to_do_vo.dart';

import '../data/data_apply/to_do_apply.dart';
import '../data/data_apply/to_do_apply_impl.dart';


class DetailCreatePageBloc extends ChangeNotifier {
  final DateFormat dateFormatter = DateFormat('yyyy-MMM-dd');
  final DateFormat timeFormatter=DateFormat.jm();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  final ToDoApply _toDoApply = ToDoApplyImpl();


  String _datePicked='';
  String _timePicked='';
  ToDoVo ? _editTodoVo;

  String get getDatePicked=>_datePicked;
  String get getTimePicked=>_timePicked;
  ToDoApply get getToDoApply=>_toDoApply;
  TextEditingController get getTitleController=>_titleController;
  TextEditingController get getContextController=>_contextController;
  TextEditingController get getNoteController=>_noteController;
  GlobalKey<FormState> get getGlobalFormKey=>_globalKey;
  ToDoVo? get getEditToDoVo=>_editTodoVo;

  void datePickedValue(String date){
    _datePicked=date;
    notifyListeners();
  }

  void timePickedValue(String time){
    _timePicked=time;
    notifyListeners();
  }
  //
  // void editToDoItemFromBox(int id){
  //   _editTodoVo=_toDoApply.todoItemFromBox(id);
  // }

  DetailCreatePageBloc(int id){
    _editTodoVo=_toDoApply.todoItemFromBox(id);
    if(_editTodoVo!=null){
      _titleController.text=_editTodoVo?.title??'';
      _contextController.text=_editTodoVo?.context??'';
      _noteController.text=_editTodoVo?.note??'';
      _datePicked=_editTodoVo?.date??'';
      _timePicked=_editTodoVo?.time??'';

    }
  }
}
