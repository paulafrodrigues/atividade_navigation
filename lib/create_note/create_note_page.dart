import 'package:flutter/material.dart';

import '../models/note_model.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3e3e3c),
        title: const Text("Criar nota"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Informe o título da nota.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Título'),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'descreva a nota';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: _formKey.currentState?.validate() == true
                      ? () {

                          final newNote = NoteModel(
                            title: titleController.text,
                            description: descriptionController.text,
                          );

                          Navigator.pop(context, newNote);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3e3e3c),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(80, 80))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Salvar nota"),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.save_alt_rounded),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}