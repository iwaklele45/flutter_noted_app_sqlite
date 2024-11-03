import 'package:flutter/material.dart';
import 'package:flutter_sqlite_noted_app/data/datasource/local_datasource.dart';

import 'package:flutter_sqlite_noted_app/data/models/note.dart';
import 'package:flutter_sqlite_noted_app/pages/home_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Note',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Plese input the title!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                label: Text('Content'),
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please input the content!i';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Note note = Note(
              id: widget.note.id,
              title: titleController.text,
              content: contentController.text,
              createdAt: DateTime.now(),
            );

            print(titleController.text);
            print(contentController.text);

            LocalDatasource().updateNoteById(note);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Note Berhasil Diubah',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.yellow,
              ),
            );

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomePage();
            }));
          }
        },
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }
}
