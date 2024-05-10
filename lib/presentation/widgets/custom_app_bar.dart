import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/presentation/delegates/search_books_delegate.dart';
import 'package:library_app/presentation/providers/search/cubit/search_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Library app',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () => _showSearch(context),
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchBooksDelegate(
        bloc: context.read<SearchCubit>(),
      ),
    ).then((value) {
      if (value == null) return;
      context.go('/book-detail/$value');
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
