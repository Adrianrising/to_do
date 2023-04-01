import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/easy_widget/easy_text_widget.dart';
import 'package:to_do_app/utils/extensions.dart';

import '../bloc/detail_create_page_bloc.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';

class DetailCreatePage extends StatelessWidget {
  const DetailCreatePage({Key? key, this.id = -1}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailCreatePageBloc>(
      create: (context) => DetailCreatePageBloc(id),
      builder: (context, child) {
        return Form(
          key: context.getCreatePageBlocInstance().getGlobalFormKey,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: toolBarHeight,
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.navigateBack(context);
                },
              ),
              actions: [
                Center(
                    child: InkWell(
                        onTap: () {
                          if (context
                                  .getCreatePageBlocInstance()
                                  .getGlobalFormKey
                                  .currentState
                                  ?.validate() ??
                              false) {
                            context
                                .getCreatePageBlocInstance()
                                .getToDoApply
                                .createToDoItem(
                                    context
                                        .getCreatePageBlocInstance()
                                        .getTitleController
                                        .text,
                                    context
                                        .getCreatePageBlocInstance()
                                        .getContextController
                                        .text,
                                    context
                                        .getCreatePageBlocInstance()
                                        .getNoteController
                                        .text,
                                    context
                                        .getCreatePageBlocInstance()
                                        .getDatePicked,
                                    context
                                        .getCreatePageBlocInstance()
                                        .getTimePicked,
                                    context
                                        .getCreatePageBlocInstance()
                                        .getEditToDoVo);
                            context.navigateBack(context);
                          }
                        },
                        child: const EasyTextWidget(text: kSaveText))),
                const SizedBox(
                  width: kSP20x,
                ),
              ],
              title: TextFormField(
                validator: (text) {
                  if(text!=null){
                    if (text.isEmpty) {
                      return kEmptyTextWarningText;
                    }
                    if(text.length>10){
                      return kMaxCharacterWarningText;
                    }
                  }
                  return null;
                },
                controller:
                    context.getCreatePageBlocInstance().getTitleController,
                decoration: const InputDecoration(
                    hintText: kToDoText, border: InputBorder.none),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: kSP50x,
                  ),
                  TextFormField(
                    validator: (text) {
                      if (text?.isEmpty ?? false) {
                        return kDescriptionEmptyWarningText;
                      }
                      return null;
                    },
                    controller: context
                        .getCreatePageBlocInstance()
                        .getContextController,
                    maxLines: todoDescriptionMaxLines,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: kToDoDescriptionText,
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(
                    height: kSP10x,
                    thickness: 1,
                    color: Colors.amber,
                  ),
                  TextField(
                    controller:
                        context.getCreatePageBlocInstance().getNoteController,
                    maxLines: toDoNoteMaxLines,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText:kNoteText ,
                      border: InputBorder.none,
                    ),
                  ),
                  const DateTimePickersView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DateTimePickersView extends StatelessWidget {
  const DateTimePickersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSP10x),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: MaterialButton(
                height: kSP50x,
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1996),
                          lastDate: DateTime(2025))
                      .then((value) {
                    if (value != null) {
                      final temp = context
                          .getCreatePageBlocInstance()
                          .dateFormatter
                          .format(value);
                      context.getCreatePageBlocInstance().datePickedValue(temp);
                    }
                  });
                },
                color: Colors.black,
                child: Selector<DetailCreatePageBloc, String>(
                  selector: (_, obj) => obj.getDatePicked,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, datePicked, _) {
                    return (datePicked.isNotEmpty)
                        ? EasyTextWidget(
                            text: context
                                .getCreatePageBlocInstance()
                                .getDatePicked
                                .toString())
                        : const EasyTextWidget(text:kDateText);
                  },
                )),
          ),
          const SizedBox(
            width: kSP3x,
          ),
          Expanded(
            child: MaterialButton(
                height: kSP50x,
                onPressed: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    if (value != null) {
                      final temp = context
                          .getCreatePageBlocInstance()
                          .timeFormatter
                          .format(
                              DateTime(2023, 03, 19, value.hour, value.minute));
                      context.getCreatePageBlocInstance().timePickedValue(temp);
                    }
                  });
                },
                color: Colors.black,
                child: Selector<DetailCreatePageBloc, String>(
                  selector: (_, obj) => obj.getTimePicked,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, timePicked, _) {
                    return (timePicked.isNotEmpty)
                        ? EasyTextWidget(
                            text: context
                                .getCreatePageBlocInstance()
                                .getTimePicked
                                .toString())
                        : const EasyTextWidget(text:kTimeText );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
