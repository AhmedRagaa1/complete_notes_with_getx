import 'package:complete_notes_with_getx/controller/note_controller.dart';
import 'package:complete_notes_with_getx/model/note_model.dart';
import 'package:complete_notes_with_getx/view/note_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchBar extends SearchDelegate
{
  noteController controller = Get.find<noteController>();
  @override
  List<Widget> buildActions(BuildContext context)
  {
   return [
     IconButton(
         onPressed: ()
         {
           query='';
         },
         icon: Icon(Icons.clear,)),
   ];
  }

  @override
  Widget buildLeading(BuildContext context)
  {
    return IconButton(
        onPressed: ()
        {
          Get.back();
        },
      icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    ),
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context)
  {
    final SuggestionList=query.isEmpty?controller.notes:
        controller.notes.where((p)
        {
          return p.title.toLowerCase().contains(query.toLowerCase())||p.content.toLowerCase().contains(query.toLowerCase());
        }).toList();

    return Container(
      padding: EdgeInsets.all(10),
      child: StaggeredGridView.countBuilder(
          itemCount: SuggestionList.length,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          staggeredTileBuilder: (index)=>StaggeredTile.fit(1),
          itemBuilder: (context,index)
          {
            return GestureDetector(
              onTap: () {
                Get.to(
                  NoteDetailPage(),
                  arguments: index,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(10, 10),
                          blurRadius: 15
                      )
                    ]
                ),

                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SuggestionList[index].title,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      SuggestionList[index].content,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 6,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.notes[index].dateTimeEdited,
                    ),
                  ],
                ),
              ),
            );


          },
      ),
    );


  }

}