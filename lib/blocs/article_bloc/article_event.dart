abstract class ArticleEvent {} // Eventlerin hepsi article state gibi article event oldugunu söylememiz gerekiyor.

class FetchArticles
    extends ArticleEvent {} //UI tarafından triggerlandıgında geçiş işlemini yapar.
