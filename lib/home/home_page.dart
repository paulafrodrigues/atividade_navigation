// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:atividade_navigation/login/login_page.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils/create_note_button.dart';
import 'home_controller.dart';
import 'home_state.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.name,
  });

  final String name;

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
        actions: [
          IconButton(
              onPressed: () {
                controller.logout().then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: Builder(builder: (context) {
        if (controller.state.runtimeType == HomeStateEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Olá ${widget.name}, seja bem vindo(a)!"),
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
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.myNotes[i].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    Text(
                      controller.myNotes[i].description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
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
    );
  }
}
