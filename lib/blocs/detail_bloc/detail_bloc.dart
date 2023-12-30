import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblogapp/blocs/detail_bloc/detail_event.dart';
import 'package:miniblogapp/blocs/detail_bloc/detail_state.dart';
import 'package:miniblogapp/repositories/article_repostory.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ArticleRepository articleRepository;

  //Statelerin hepsini soyutlayıp tek bir alandan vememiz gerekiyor.
  DetailBloc({required this.articleRepository}) : super(DetailInitial()) {
    //extends ettiğimiz class ın başlangıc durumunu ister.Burada initial ile başlıcak.

    on<FetchDetailId>(
        _onFetchDetailId); // event fırladıgında bir fonksiyon calıstırabilen bir bloc oldu
  }
//Bu fonksiyondaki stat i değiştiricez !
  void _onFetchDetailId(FetchDetailId event, Emitter<DetailState> emit) async {
    //State i değiştirmek için emit kullanıcaz !
    emit(DetailLoading());

    try {
      final articles = await articleRepository.fetchBlogId(event.id);
      //article lar basarılı bir şekilde yüklendiyse burası
      emit(DetailLoaded(
          blogs:
              articles)); // article ve blog aynı isimdeler aynı şeyi ifade ediyorlar.
      //blocları catch ederken bir problem olmus blogları articleErrors durumuna almamız lazım
    } catch (e) {
      emit(DetailError());
    }
  }
}
