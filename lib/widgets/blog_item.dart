import 'package:flutter/material.dart';
import 'package:miniblogapp/models/blog.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 4 / 2,
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[250],
                  child: Center(child: Image.network(blog.thumbnail!)),
                )),
            ListTile(
              title: Text(blog.title!),
              subtitle: Text(blog.author!),
            )
          ],
        ),
      ),
    );
  }
}
