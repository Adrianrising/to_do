import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/easy_widget/easy_text_widget.dart';
import 'package:to_do_app/utils/extensions.dart';

import '../bloc/detail_create_page_bloc.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';

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