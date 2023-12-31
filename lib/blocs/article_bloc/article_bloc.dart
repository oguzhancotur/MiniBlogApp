import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblogapp/blocs/article_bloc/article_event.dart';
import 'package:miniblogapp/blocs/article_bloc/article_state.dart';
import 'package:miniblogapp/repositories/article_repostory.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  //Statelerin hepsini soyutlayıp tek bir alandan vememiz gerekiyor.
  ArticleBloc({required this.articleRepository}) : super(ArticlesInitial()) {
    //extends ettiğimiz class ın başlangıc durumunu ister.Burada initial ile başlıcak.

    on<FetchArticles>(
        _onFetchArticles); // event fırladıgında bir fonksiyon calıstırabilen bir bloc oldu

    on<PostArticle>(_onPostArticle);
  }
//Bu fonksiyondaki stat i değiştiricez !
  void _onFetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    //State i değiştirmek için emit kullanıcaz !
    emit(ArticlesLoading());

    try {
      final articles = await articleRepository.fetchAllBlogs();
      //article lar basarılı bir şekilde yüklendiyse burası
      emit(ArticlesLoaded(
          blogs:
              articles)); // article ve blog aynı isimdeler aynı şeyi ifade ediyorlar.
      //blocları catch ederken bir problem olmus blogları articleErrors durumuna almamız lazım
    } catch (e) {
      emit(ArticlesError());
    }
  }

  void _onPostArticle(PostArticle event, Emitter<ArticleState> emit) async {
    await articleRepository.postBlog(
        event.title, event.content, event.author, event.image);
  }
}
