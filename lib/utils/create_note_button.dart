import 'package:flutter/material.dart';

import '../create_note/create_note_page.dart';
import '../home/home_controller.dart';
import '../models/note_model.dart';

// ignore: must_be_immutable
class CreateNoteButton extends StatelessWidget {
  HomeController controller;
  bool? small;
  CreateNoteButton({super.key, required this.controller, this.small});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _createNoteTo(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3E3E3C),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)
            
                  ),
      ),
      child: const Icon(Icons.edit),
    );
  }

  _createNoteTo(BuildContext context) async {


    await Navigator.push<NoteModel?>(
      context,
      MaterialPageRoute(builder: (_) => const CreateNotePage()),
    ).then((value) {
      if (value != null && value.runtimeType == NoteModel) {


        controller.addNote(note: value);
      } else {

      }
    });


  }
}