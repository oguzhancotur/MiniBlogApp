import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:miniblogapp/blocs/detail_bloc/detail_bloc.dart';
import 'package:miniblogapp/blocs/detail_bloc/detail_event.dart';
import 'package:miniblogapp/blocs/detail_bloc/detail_state.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailInitial) {
          context.read<DetailBloc>().add(FetchDetailId(id: widget.id));
          return const Center(
            child: Text("İstek Atılıyor"),
          );
        }
        if (state is DetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DetailLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              title: Text(state.blogs.title.toString()),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(state.blogs.thumbnail.toString()),
                  ),
                  Text(
                    state.blogs.author.toString(),
                    style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.blogs.content.toString(),
                    style: const TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is DetailError) {
          return const Center(
            child: Text(
              "Hata Alındı",
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: Colors.redAccent),
            ),
          );
        }
        return const Center(
          child: Text(
            "Veri Alınamadı",
            style:
                TextStyle(fontWeight: FontWeight.w900, color: Colors.redAccent),
          ),
        );
      },
    );
  }
}
