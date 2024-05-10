import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/presentation/providers/book_detail/cubit/book_detail_cubit.dart';
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is BookDetailLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: color as Color? ?? Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Hero(
                                tag: state.book.isbn13,
                                child: CachedNetworkImage(
                                  imageUrl: state.book.image,
                                  height: 250,
                                  placeholder: (context, url) => const SizedBox(
                                      height: 250,
                                      width: 180,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      )),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )),
                          const SizedBox(height: 10),
                          Text(
                            state.book.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.book.authors,
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
                                if (i < int.parse(state.book.rating))
                                  const Icon(Icons.star, color: Colors.amber)
                                else
                                  const Icon(Icons.star, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    state.book.pages,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Pages',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.book.price,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Price',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.book.year,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Year',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            state.book.desc,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is BookDetailError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                }),
          ],
        ),
        bottomNavigationBar: BlocBuilder<BookDetailCubit, BookDetailState>(
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
        ));
  }
}
