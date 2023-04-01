import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/bloc/home_page_bloc.dart';
import 'package:to_do_app/easy_widget/easy_text_widget.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';

class SliverAppBarView extends StatelessWidget {
  const SliverAppBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      pinned: true,
      expandedHeight: sliverAppBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            EasyTextWidget(
              text: kToDoText,
              fontSize: kFZ30,
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kSP20x),
        child: AppBar(
          backgroundColor: Colors.black,
          title: Selector<HomePageBloc, bool>(
            selector: (_, obj) => obj.getTitleVisibility,
            builder: (context, isVisible, _) {
              return AnimatedOpacity(
                opacity: (isVisible) ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                child: const EasyTextWidget(
                  text: kToDoText,
                  fontSize: kFZ30,
                ),
              );
            },
          ),
          leading: const Icon(
            Icons.menu,
            size: kFZ40,
          ),
        ),
      ),
    );
  }
}