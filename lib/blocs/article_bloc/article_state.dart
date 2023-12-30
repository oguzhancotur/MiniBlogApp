//initial => durum proje ilk acıldıgında oldugu durum

//ArticlesInitial
//ArticlesLoading => article a istek attığında loading durumuna geçer
//ArticleLoaded => istekten cevap gelirse ArticleLoaded kısmı gelsin
//ArticlesError => Eğer hatalı bir durum gelirse eror kısmı gelsin

//Stateleri tanımlamak için önce statin kendisini tanımlamamız lazım

import 'package:miniblogapp/models/blog.dart';

abstract class ArticleState {}

class ArticlesInitial extends ArticleState {}

class ArticlesLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Blog> blogs;

  ArticlesLoaded({required this.blogs}); // loaded olan datayı geriye döner
}

class ArticlesError extends ArticleState {}
