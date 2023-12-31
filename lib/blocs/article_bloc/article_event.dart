abstract class ArticleEvent {} // Eventlerin hepsi article state gibi article event oldugunu söylememiz gerekiyor.

class FetchArticles
    extends ArticleEvent {} //UI tarafından triggerlandıgında geçiş işlemini yapar.

class PostArticle extends ArticleEvent {
  String title;
  String content;
  String author;
  String image;
  PostArticle({
    required this.title,
    required this.content,
    required this.author,
    required this.image,
  });
} //soyut sınıf , nesneye yönelik programlama bunlara çalış !

 