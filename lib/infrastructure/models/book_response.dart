class BookResponse {
  final List<Book> books;
  final String total;

  BookResponse({
    required this.books,
    required this.total,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        total: json["total"],
      );
}

class Book {
  final String? title;
  final String? subtitle;
  final String? isbn13;
  final String? price;
  final String? image;
  final String? url;

  Book({
    this.title,
    this.subtitle,
    this.isbn13,
    this.price,
    this.image,
    this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        subtitle: json["subtitle"],
        isbn13: json["isbn13"],
        price: json["price"],
        image: json["image"],
        url: json["url"],
      );
}
