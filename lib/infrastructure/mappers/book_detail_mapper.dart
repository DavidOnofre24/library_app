import 'package:library_app/domain/entities/book_detail_entity.dart';
import 'package:library_app/infrastructure/models/book_detail_response.dart';

class BookDetailMapper {
  static BookDetailEntity bookDetailResponseToEntity(
      BookDetailResponse response) {
    return BookDetailEntity(
      title: response.title!,
      subtitle: response.subtitle!,
      authors: response.authors ?? '',
      publisher: response.publisher ?? '',
      isbn13: response.isbn13!,
      pages: response.pages ?? '',
      year: response.year ?? '',
      rating: response.rating ?? '',
      desc: response.desc ?? '',
      price: response.price ?? '',
      image: response.image ?? '',
      url: response.url ?? '',
      pdf: response.pdf != null ? response.pdf!.chapter2 ?? '' : '',
    );
  }
}
