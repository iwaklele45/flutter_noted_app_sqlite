// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_sqlite_noted_app/data/datasource/local_datasource.dart';

import 'package:flutter_sqlite_noted_app/data/models/note.dart';
import 'package:flutter_sqlite_noted_app/pages/edit_noted.dart';
import 'package:flutter_sqlite_noted_app/pages/home_page.dart';

class DetalPage extends StatefulWidget {
  const DetalPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<DetalPage> createState() => _DetalPageState();
}

class _DetalPageState extends State<DetalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Noted',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Note'),
                        content: Text('Are you sure delete this note?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                          TextButton(
                            onPressed: () async {
                              await LocalDatasource()
                                  .deleteNoteById(widget.note.id!);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Note Was Deleted',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              )),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.note.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.note.content,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditPage(
                  note: widget.note,
                );
              },
            ),
          );
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
