import 'package:blocpagination/feature/data/repository.dart';
import 'package:blocpagination/feature/pagination/bloc/pagination_bloc.dart';
import 'package:blocpagination/presentation/screens/pagination_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    Repository repository = Repository();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (paginationScreenContext) => BlocProvider<PaginationBloc>(
                lazy: false,
                create: (paginationScreenBlocContext) =>
                    PaginationBloc(Repo: repository)
                      ..add(PaginationPageRequest()),
                child: PaginationScreen()));

      default:
        return null;
    }
  }
}
