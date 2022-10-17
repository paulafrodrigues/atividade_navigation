// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils/create_note_button.dart';
import 'home_controller.dart';
import 'home_state.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  UserModel user;
  HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  @override
  void initState() {
    controller = HomeController(onUpdate: () {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E3E3C),
        title: const Text("TODO APP"),
        centerTitle: true,

      ),
      body: Builder(builder: (context) {
        if (controller.state.runtimeType == HomeStateEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Olá ${widget.user.name}, seja bem vindo(a)!"),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Seu TODO está vazio!!!',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                const Text("Criei uma nova nota."),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CreateNoteButton(controller: controller),
                ),
              ],
            ),
          );
        } else if (controller.state.runtimeType == HomeStateSuccess) {
          return ListView.builder(
            itemCount: controller.myNotes.length,
            itemBuilder: (context, i) {
              return Card(
               
                child: Column(
                  children: [
                    const ListTile(
                      leading:  CircleAvatar(
                        backgroundColor: Color(0xFF188f60),
                        child: Icon(
                          Icons.article,
                        ),
                      ),
                    ),
                  ],
                )
              );
            },
          );
        }

        return Container();
      }),
      floatingActionButton: CreateNoteButton(
        controller: controller,
        small: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF188F60),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture:
                  const CircleAvatar(child: Icon(Icons.person)),
              accountName: Text(widget.user.name),
              accountEmail: Text(widget.user.email),
            ),

             ],
        ),
      ),
    );
  }
  }