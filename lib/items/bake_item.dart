import 'package:flutter/material.dart';

class BakeItem extends StatelessWidget {
  final String title;
  final String author;

  const BakeItem(this.title, this.author, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.image),
        title: Text(title),
        subtitle: Text(author),
        trailing: const Icon(Icons.favorite_border),
      ),
    );
  }
}
