import 'package:complete_notes_with_getx/controller/note_controller.dart';
import 'package:complete_notes_with_getx/widgets/alarm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_note_page.dart';
import 'home_page.dart';

class NoteDetailPage extends StatelessWidget {
  final noteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () {
              Get.to(
                EditNotePage(),
                arguments: i,
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextButton(

                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDioooog(
                                  contentText:
                                      "Are you sure you want to delete the note?",
                                  confirmFunction: () {
                                    controller.deleteNote(controller.notes[i].id);
                                    Get.offAll(HomePage());
                                  },
                                  declineFunction: () {
                                    Get.back();
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.delete,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(

                          onPressed: () {
                            controller.shareNote(
                              controller.notes[i].title,
                              controller.notes[i].content,
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.share,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Created :  " +
                                  controller.notes[i].dateTimeCreated,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Content Word Count :  " +
                                  controller.contentWordCount.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Content Character Count :  " +
                                  controller.contentCharCount.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Created by AHMED RAGAA",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
              );
            },
          ),
        ],
      ),
      body: GetBuilder<noteController>(
        builder: (_) => Scrollbar(
          child: Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    controller.notes[i].title,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SelectableText(
                    controller.notes[i].content,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Last Edited : " + controller.notes[i].dateTimeEdited,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
