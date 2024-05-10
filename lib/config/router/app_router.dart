import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/config/dependency_injection/dependency_injection.dart';
import 'package:library_app/presentation/providers/search/cubit/search_cubit.dart';
import 'package:library_app/presentation/screens/screens.dart';
import 'package:library_app/presentation/providers/providers.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      BookCubit(bookRepository: getIt.get())..getReleaseBooks(),
                ),
                BlocProvider(
                  create: (context) => SearchCubit(
                    bookSearchByQuery: getIt.get(),
                    addSearchHistoryUseCase: getIt.get(),
                    getSearchHistoryUseCase: getIt.get(),
                  )..getSearchHistories(),
                ),
              ],
              child: const HomeScreen(),
            ),
        routes: [
          GoRoute(
            path: 'book-detail/:id',
            name: BookDetailScreen.name,
            builder: (context, state) => BlocProvider(
              create: (context) => BookDetailCubit(bookRepository: getIt.get())
                ..getBookDetail(state.params['id'] ?? '0'),
              child: const BookDetailScreen(),
            ),
          ),
        ]),
  ],
);
