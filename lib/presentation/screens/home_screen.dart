import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/presentation/providers/book/cubit/book_cubit.dart';
import 'package:library_app/presentation/widgets/custom_app_bar.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<BookCubit, BookState>(builder: (context, state) {
                if (state is BookLoading) {
                  return Center(
                      child: Lottie.asset('assets/lottie/books.json'));
                }

                if (state is BookLoaded) {
                  return BooksLoadedWidget(booksList: state.books);
                }

                if (state is BookError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox();
              })
            ],
          ),
        ));
  }
}

class BooksLoadedWidget extends StatelessWidget {
  final List<BookEntity> booksList;
  const BooksLoadedWidget({super.key, required this.booksList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: const Text(
            'New Releases',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (booksList.length / 2).ceil(),
          itemBuilder: (context, index) {
            int startIndex = index * 2;
            int endIndex = startIndex + 2 > booksList.length
                ? booksList.length
                : startIndex + 2;

            return IntrinsicHeight(
              child: Row(
                children: List.generate(endIndex - startIndex, (i) {
                  final book = booksList[startIndex + i];
                  return ItemBook(book: book);
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ItemBook extends StatefulWidget {
  const ItemBook({
    super.key,
    required this.book,
  });

  final BookEntity book;

  @override
  State<ItemBook> createState() => _ItemBookState();
}

class _ItemBookState extends State<ItemBook> {
  Color getDarkRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);

    r = (r * 0.8).toInt();
    g = (g * 0.8).toInt();
    b = (b * 0.8).toInt();

    return Color.fromRGBO(r, g, b, 1);
  }

  Color? _randomColor;

  @override
  Widget build(BuildContext context) {
    _randomColor ??= getDarkRandomColor();
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              context.go('/book-detail/${widget.book.isbn13}',
                  extra: _randomColor);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: const Border(
                              left: BorderSide(width: 0.5, color: Colors.grey),
                              right: BorderSide(width: 0.5, color: Colors.grey),
                              top: BorderSide(width: 0.5, color: Colors.grey)),
                          color: _randomColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Hero(
                        tag: widget.book.isbn13,
                        child: CachedNetworkImage(
                          imageUrl: widget.book.image,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 0.5, color: Colors.grey),
                        right: BorderSide(width: 0.5, color: Colors.grey),
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            widget.book.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.book.price,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
