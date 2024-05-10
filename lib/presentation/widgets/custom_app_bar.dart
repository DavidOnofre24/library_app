import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/presentation/delegates/search_books_delegate.dart';
import 'package:library_app/presentation/providers/search/cubit/search_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return AppBar(
      title: Text('Library app', style: titleStyle),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchBooksDelegate(
                bloc: context.read<SearchCubit>(),
              ),
            ).then((value) {
              if (value == null) return;
              context.go('/book-detail/$value');
            });
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
    // return SafeArea(
    //     bottom: false,
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 10),
    //       child: SizedBox(
    //         width: double.infinity,
    //         child: Row(
    //           children: [
    //             const SizedBox(width: 10),
    //             Text('Library app', style: titleStyle),
    //             const Spacer(),
    //             IconButton(
    //                 onPressed: () {
    //                   showSearch(
    //                     context: context,
    //                     delegate: SearchBooksDelegate(
    //                       bloc: context.read<SearchCubit>(),
    //                     ),
    //                   ).then((value) {
    //                     if (value == null) return;
    //                     context.go('/book-detail/$value');
    //                   });
    //                 },
    //                 icon: const Icon(Icons.search))
    //           ],
    //         ),
    //       ),
    //     ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
