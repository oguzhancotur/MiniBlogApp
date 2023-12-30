import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblogapp/blocs/article_bloc/article_bloc.dart';
import 'package:miniblogapp/blocs/detail_bloc/detail_bloc.dart';
import 'package:miniblogapp/repositories/article_repostory.dart';
import 'package:miniblogapp/screens/homepage.dart';

void main() {
  // Uygulama başlatılırken çağrılacak ana işlev.
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ArticleBloc>(
        create: (context) =>
            ArticleBloc(articleRepository: ArticleRepository()),
      ),
      BlocProvider<DetailBloc>(
        create: (context) => DetailBloc(articleRepository: ArticleRepository()),
      )
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    ),
  ));
}
