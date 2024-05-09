import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/presentation/providers/search/cubit/search_cubit.dart';

class SearchBooksDelegate extends SearchDelegate<String?> {
  final SearchCubit bloc;

  SearchBooksDelegate({required this.bloc});
  @override
  String get searchFieldLabel => 'Search books';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          bloc.clearSearch();
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        bloc.clearSearch();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchLoaded) {
          return buildResultsAndSuggestions(state.items, context);
        } else if (state is SearchError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(
            child: Text('Start searching books'),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      bloc.search(query);
    }
    return buildResults(context);
  }

  Widget buildResultsAndSuggestions(
      List<BookEntity> items, BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('No books found'),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ItemListile(
        item: items[index],
        onTap: () {
          bloc.clearSearch();
          close(context, items[index].isbn13);
        },
      ),
    );
  }
}

class ItemListile extends StatelessWidget {
  final BookEntity item;
  final void Function()? onTap;

  const ItemListile({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(item.title),
      subtitle: Text(item.price),
    );
  }
}
