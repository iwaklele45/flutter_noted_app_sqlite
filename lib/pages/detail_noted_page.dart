import 'package:flutter/material.dart';

class DetalPage extends StatefulWidget {
  const DetalPage({super.key});

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
            color: Color.fromARGB(255, 129, 50, 50),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Title',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Content',
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
