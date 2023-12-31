abstract class DetailEvent {} // Eventlerin hepsi article state gibi article event oldugunu söylememiz gerekiyor.

class FetchDetailId extends DetailEvent {
  final String id;

  FetchDetailId({required this.id});
} //UI tarafından triggerlandıgında geçiş işlemini yapar.

class ResetEvent extends DetailEvent {}
