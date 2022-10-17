import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_model.dart';
import '../utils/shared_preferences.keys.dart';
import 'home_state.dart';

class HomeController {
  HomeState state = HomeStateEmpty();

  final VoidCallback onUpdate;
  List<NoteModel> myNotes = <NoteModel>[];
//  UserModel user;
  late final SharedPreferences prefs;

  HomeController({required this.onUpdate}) {
    init();
  }

  void updateState(HomeState newState) {
    state = newState;
    onUpdate();
  }

  Future<void> init() async {
    updateState(HomeStateLoading());


    prefs = await SharedPreferences.getInstance();
    //await prefs.remove(SharedPreferencesKeys.notes);

    final notes = prefs.getString(SharedPreferencesKeys.notes);
    if (notes != null && notes.isNotEmpty) {
      final listJsonNotes = jsonDecode(notes);

      myNotes =
          List.from(listJsonNotes).map((e) => NoteModel.fromJson(e)).toList();
      if (myNotes.isEmpty) {
        updateState(HomeStateEmpty());
      } else {
        updateState(HomeStateSuccess());
      }
    } else {


      updateState(HomeStateEmpty());
    }
  }

  Future<void> addNote({required NoteModel note}) async {
    updateState(HomeStateLoading());


    myNotes.add(note);


    prefs.setString(SharedPreferencesKeys.notes, jsonEncode(myNotes));
    updateState(HomeStateSuccess());
  }

}