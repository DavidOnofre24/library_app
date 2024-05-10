import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/presentation/providers/search/cubit/search_cubit.dart';
import 'package:lottie/lottie.dart';

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
          return Center(child: Lottie.asset('assets/lottie/books.json'));
        }
        if (state is SearchLoaded) {
          return buildResultsAndSuggestions(state.items, context);
        }
        if (state is SearchError) {
          return Center(child: Text(state.message));
        }
        if (state is SearchInitial) {
          if (state.searchHistories.isEmpty) {
            return const Center(
              child: Text('Start searching books'),
            );
          }
          return ListView.builder(
            itemCount: state.searchHistories.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.history),
              title: Text(state.searchHistories[index]),
              onTap: () {
                query = state.searchHistories[index];
                bloc.search(state.searchHistories[index]);
              },
            ),
          );
        }
        return const SizedBox();
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
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.network(
          item.image,
          width: 50,
          height: 100,
        ),
      ),
      onTap: onTap,
      title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(item.price),
    );
  }
}
