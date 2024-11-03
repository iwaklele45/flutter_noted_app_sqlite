import 'package:flutter/material.dart';
import 'package:flutter_sqlite_noted_app/data/datasource/local_datasource.dart';
import 'package:flutter_sqlite_noted_app/data/models/note.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Noted",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
                  return 'Please input the title!';
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
                  return 'Please input the content!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Note note = Note(
                    title: titleController.text,
                    content: contentController.text,
                    createdAt: DateTime.now(),
                  );

                  LocalDatasource().insertNote(note);
                  titleController.clear();
                  contentController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note Berhasil Ditambah'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context, note);
                }
              },
              child: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
