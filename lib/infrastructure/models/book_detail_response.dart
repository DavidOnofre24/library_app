class BookDetailResponse {
  final String? error;
  final String? title;
  final String? subtitle;
  final String? authors;
  final String? publisher;
  final String? isbn10;
  final String? isbn13;
  final String? pages;
  final String? year;
  final String? rating;
  final String? desc;
  final String? price;
  final String? image;
  final String? url;
  final Pdf? pdf;

  BookDetailResponse({
    this.error,
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.isbn10,
    this.isbn13,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.price,
    this.image,
    this.url,
    this.pdf,
  });

  factory BookDetailResponse.fromJson(Map<String, dynamic> json) =>
      BookDetailResponse(
        error: json["error"],
        title: json["title"],
        subtitle: json["subtitle"],
        authors: json["authors"],
        publisher: json["publisher"],
        isbn10: json["isbn10"],
        isbn13: json["isbn13"],
        pages: json["pages"],
        year: json["year"],
        rating: json["rating"],
        desc: json["desc"],
        price: json["price"],
        image: json["image"],
        url: json["url"],
        pdf: json["pdf"] == null ? null : Pdf.fromJson(json["pdf"]),
      );
}

class Pdf {
  final String? chapter2;
  final String? chapter5;

  Pdf({
    this.chapter2,
    this.chapter5,
  });

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
        chapter2: json["Chapter 2"],
        chapter5: json["Chapter 5"],
      );
}
