import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/bloc/home_page_bloc.dart';
import 'package:to_do_app/data/vos/to_do_vo.dart';
import 'package:to_do_app/easy_widget/easy_text_widget.dart';
import 'package:to_do_app/pages/detail_create_page.dart';
import 'package:to_do_app/utils/extensions.dart';

import '../constant/dimens.dart';
import '../constant/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var top = 0.0;
  late double appBarHeight;

  @override
  Widget build(BuildContext context) {
    appBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider<HomePageBloc>(
          create: (_) => HomePageBloc(),
          builder: (context, child) => NestedScrollView(
                controller: context.read<HomePageBloc>().getScrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
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
                  )
                ],
                body: Container(
                  margin: const EdgeInsets.only(top: kSP50x),
                  child: SingleChildScrollView(
                    child: Selector<HomePageBloc, List<ToDoVo>>(
                      selector: (_, obj) => obj.getToDoList,
                      shouldRebuild: (previous, next) => previous != next,
                      builder: (context, toDoList, _) {
                        return Wrap(spacing: kSP20x, runSpacing: kSP55x, children: [
                          for (int index = 0,length=toDoList.length;index<length ; index++)
                            Card(
                              margin: const EdgeInsets.only(left: kSP10x),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                onTap: (){
                                  context.navigateToNextScreen(
                                      context,
                                       DetailCreatePage(id:toDoList[index].id??-1));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          toDoItemTitleWidth,
                                      color:Colors.black,
                                      child: Row(
                                        children: [
                                          const Expanded(child: EasyTextWidget(text: kToDoText)),
                                          PopupMenuButton(
                                            onSelected: (value){
                                              if(value==kEditText){
                                                context.navigateToNextScreen(
                                                    context,
                                                    DetailCreatePage(id:toDoList[index].id??-1));
                                              }
                                              if(value==kDeleteText){
                                                context.getHomePageBlocInstance().getToDoApply.deleteToDoItemFromBox(toDoList[index].id??-1);
                                              }
                                            },
                                            itemBuilder: (_) {
                                              return [
                                                const PopupMenuItem(
                                                  value: kEditText,
                                                  child: EasyTextWidget(text: kEditText),
                                                ),
                                                const PopupMenuItem(
                                                  value: kDeleteText,
                                                  child: EasyTextWidget(text: kDeleteText),
                                                )
                                              ];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          toDoItemHeight,
                                      width: MediaQuery.of(context).size.width *
                                          toDoItemTitleWidth,
                                      child: Padding(
                                        padding: const EdgeInsets.all(kSP8x),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                  width: MediaQuery.of(context).size.width *
                                                      toDoItemTitleWidth,
                                                  child:  Center(
                                                    child: EasyTextWidget(
                                                      text:toDoList[index].title??'',
                                                      fontSize: kFZ25,
                                                    ),
                                                  )),
                                            ),
                                             Expanded(
                                                flex: 2,
                                                child: EasyTextWidget(
                                                  text:
                                                     toDoList[index].context??'',
                                                  fontSize: kFZ15,
                                                )),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.amber,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children:  [
                                                  const EasyTextWidget(
                                                    text: kNoteText,
                                                    fontSize: kFZ16,
                                                  ),
                                                  Expanded(
                                                      child: EasyTextWidget(
                                                    text: toDoList[index].note??'',
                                                    fontSize: kFZ15,
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                            toDoItemTitleWidth,
                                        color: Colors.black,
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            EasyTextWidget(
                                              text:toDoList[index].date??'',
                                              fontSize: kFZ16,
                                            ),
                                            EasyTextWidget(
                                              text:toDoList[index].time??'',
                                              fontSize: kFZ16,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            )
                        ]);
                      },
                    ),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigateToNextScreen(
              context,
              const DetailCreatePage());
        },
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.create,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
