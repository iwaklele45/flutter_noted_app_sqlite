import 'package:flutter/material.dart';
import 'package:flutter_sqlite_noted_app/data/datasource/local_datasource.dart';
import 'package:flutter_sqlite_noted_app/data/models/note.dart';
import 'package:flutter_sqlite_noted_app/pages/add_noted_page.dart';
import 'package:flutter_sqlite_noted_app/pages/detail_noted_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  bool isLoading = false;

  Future<void> getAllNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await LocalDatasource().getAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Noted App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : notes.isEmpty
              ? const Center(
                  child: Text('No Notes!'),
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetalPage(
                                note: notes[index],
                              );
                            },
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notes[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  notes[index].content,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: notes.length,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddPage();
              },
            ),
          );
          getAllNotes();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
