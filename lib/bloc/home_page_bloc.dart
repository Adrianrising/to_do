
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/data/data_apply/to_do_apply.dart';
import 'package:to_do_app/data/data_apply/to_do_apply_impl.dart';
import 'package:to_do_app/data/vos/to_do_vo.dart';

class HomePageBloc extends ChangeNotifier{
  final ScrollController _scrollController=ScrollController();
  final ToDoApply _toDoApply=ToDoApplyImpl();

  List<ToDoVo> _toDoList=[];

  bool _isTitleVisible=true;

  bool get getTitleVisibility=>_isTitleVisible;

  ToDoApply get getToDoApply=>_toDoApply;

  List<ToDoVo> get getToDoList=>_toDoList;

  ScrollController get getScrollController=>_scrollController;

  HomePageBloc(){
    _scrollController.addListener(() {
      _isTitleVisible=_scrollController.offset<165.0;
      notifyListeners();
    });

    _toDoApply.toDoListFromBoxAsStream().listen((event) {
      _toDoList=event??[];
      notifyListeners();
    });
  }


}