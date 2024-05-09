import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/presentation/providers/book_detail/cubit/book_detail_cubit.dart';

class BookDetailScreen extends StatelessWidget {
  static const name = 'book-detail';
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Detail'),
        ),
        body: BlocBuilder<BookDetailCubit, BookDetailState>(
            bloc: context.read<BookDetailCubit>(),
            builder: (context, state) {
              if (state is BookDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is BookDetailLoaded) {
                return Center(child: Text(state.book.title));
              }

              if (state is BookDetailError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            }));
  }
}
