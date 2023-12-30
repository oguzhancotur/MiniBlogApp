//initial => durum proje ilk acıldıgında oldugu durum

//ArticlesInitial
//ArticlesLoading => article a istek attığında loading durumuna geçer
//ArticleLoaded => istekten cevap gelirse ArticleLoaded kısmı gelsin
//ArticlesError => Eğer hatalı bir durum gelirse eror kısmı gelsin

//Stateleri tanımlamak için önce statin kendisini tanımlamamız lazım

import 'package:miniblogapp/models/blog.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final Blog blogs;

  DetailLoaded({required this.blogs}); // loaded olan datayı geriye döner
}

class DetailError extends DetailState {}
