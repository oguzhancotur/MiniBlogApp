import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblogapp/blocs/article_bloc/article_bloc.dart';
import 'package:miniblogapp/blocs/article_bloc/article_event.dart';
import 'package:miniblogapp/blocs/article_bloc/article_state.dart';
import 'package:miniblogapp/models/blog.dart';
import 'package:miniblogapp/screens/add_blog.dart';
import 'package:miniblogapp/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "Blog Sayfası",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool? result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AddBlog()),
              );
              if (result == true) {
                context.read<ArticleBloc>().add(FetchArticles());
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticlesInitial) {
              // bloc a fetchArticles eventi göndermek
              context
                  .read<ArticleBloc>()
                  .add(FetchArticles()); // UI dan bloga event gelir.!
              return const Center(
                child: Text("İstek atılıyor..."),
              );
            }

            if (state is ArticlesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ArticlesLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ArticleBloc>().add(FetchArticles());
                },
                child: ListView.builder(
                    itemCount: state.blogs.length,
                    itemBuilder: (context, index) =>
                        BlogItem(blog: state.blogs[index])),
              );
            }

            if (state is ArticlesError) {
              return const Center(
                child: Text("Bloc'lar yüklenirken hata oluştu."),
              );
            }

            return const Center(
              child: Text("Unknow State"),
            );
          },
        ),
      ),
    );
  }
}
