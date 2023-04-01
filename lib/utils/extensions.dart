
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/bloc/detail_create_page_bloc.dart';
import 'package:to_do_app/bloc/home_page_bloc.dart';
import 'package:to_do_app/data/data_apply/to_do_apply.dart';

extension Navigation on BuildContext{
  Future navigateToNextScreen(BuildContext context,Widget nextScreen)=>
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>nextScreen));

  Future navigateToNextScreenReplace(BuildContext context,Widget nextScreen)=>
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>nextScreen));

  void navigateBack(BuildContext context)=>
      Navigator.of(context).pop();

  HomePageBloc getHomePageBlocInstance()=>read<HomePageBloc>();

  DetailCreatePageBloc getCreatePageBlocInstance()=>read<DetailCreatePageBloc>();



}