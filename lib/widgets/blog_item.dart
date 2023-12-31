import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblogapp/blocs/detail_bloc/detail_bloc.dart';
import 'package:miniblogapp/blocs/detail_bloc/detail_event.dart';
import 'package:miniblogapp/models/blog.dart';
import 'package:miniblogapp/screens/blog_details.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<DetailBloc>().add(ResetEvent());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetails(id: blog.id!),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 4 / 2, child: Image.network(blog.thumbnail!)),
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
