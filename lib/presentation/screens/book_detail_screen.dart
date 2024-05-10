import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/domain/entities/entities.dart';
import 'package:library_app/presentation/providers/book_detail/cubit/book_detail_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailScreen extends StatelessWidget {
  static const name = 'book-detail';
  final Object? color;

  const BookDetailScreen({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[800],
            height: 70,
            width: double.infinity,
          ),
          BlocBuilder<BookDetailCubit, BookDetailState>(
              bloc: context.read<BookDetailCubit>(),
              builder: (context, state) {
                if (state is BookDetailLoading) {
                  return Center(
                      child: Lottie.asset('assets/lottie/books.json'));
                }

                if (state is BookDetailLoaded) {
                  return _BookDetailWidget(color: color, book: state.book);
                }

                if (state is BookDetailError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              }),
        ],
      ),
      bottomNavigationBar: const _UrlButton(),
    );
  }
}

class _BookDetailWidget extends StatelessWidget {
  final BookDetailEntity book;

  const _BookDetailWidget({
    required this.color,
    required this.book,
  });

  final Object? color;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _Image(color: color, book: book),
          const SizedBox(height: 10),
          Text(
            book.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            book.authors,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                if (i < int.parse(book.rating))
                  const Icon(Icons.star, color: Colors.amber)
                else
                  const Icon(Icons.star, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
          _RowBookDetails(book: book),
          const SizedBox(height: 20),
          Text(
            book.desc,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class _RowBookDetails extends StatelessWidget {
  const _RowBookDetails({
    required this.book,
  });

  final BookDetailEntity book;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ItemRowBook(title: 'Pages', value: book.pages),
        _ItemRowBook(title: 'Price', value: book.price),
        _ItemRowBook(title: 'Year', value: book.year),
      ],
    );
  }
}

class _ItemRowBook extends StatelessWidget {
  final String title;
  final String value;
  const _ItemRowBook({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.color,
    required this.book,
  });

  final Object? color;
  final BookDetailEntity book;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: color as Color? ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Hero(
          tag: book.isbn13,
          child: CachedNetworkImage(
            imageUrl: book.image,
            height: 250,
            placeholder: (context, url) => const SizedBox(
                height: 250,
                width: 180,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }
}

class _UrlButton extends StatelessWidget {
  const _UrlButton();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailCubit, BookDetailState>(
      bloc: context.read<BookDetailCubit>(),
      builder: (context, state) {
        if (state is! BookDetailLoaded) {
          return const SizedBox();
        }
        return Container(
            color: Colors.grey[800],
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            launchUrl(
                              Uri.parse(state.book.url),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: const Text('Get it')),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
