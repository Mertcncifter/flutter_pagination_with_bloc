import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blocpagination/feature/data/repository.dart';
import 'package:blocpagination/feature/pagination/model/user.dart';
import 'package:equatable/equatable.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final Repository Repo;
  int page = 1;
  PaginationBloc({required this.Repo}) : super(PaginationInitial());

  @override
  Stream<PaginationState> mapEventToState(PaginationEvent event) async* {
    if (event is PaginationPageRequest) {
      yield* mapPostLoadedToState();
    } else if (event is PaginationAdded) {
      yield* _mapPostAddedToState(event);
    } else if (event is PaginationUpdated) {
      yield* _mapPostUpdatedToState(event);
    } else if (event is PaginationDeleted) {
      yield* _mapPostDeletedToState(event);
    } else if (event is PaginationAll) {
    } else if (event is ClearCompleted) {}
  }

  Stream<PaginationState> mapPostLoadedToState() async* {
    try {
      if (state is PaginationLoading) return;
      final currentState = state;
      var oldUsers = <User>[];
      if (currentState is PaginationLoaded) {
        oldUsers = currentState.users;
      }
      yield PaginationLoading(oldUsers, isFirstFetch: page == 1);
      var jsonStr = await Repo.getUsers(page);
      dynamic jsonDyn = json.decode(jsonStr.toString());
      if (jsonDyn["success"]) {
        page++;
        List<dynamic> getListDynamic =
            jsonDyn["data"]["items"] as List<dynamic>;
        List<User> newPosts =
            getListDynamic.map((e) => User.fromJson(e)).toList();
        final posts = (state as PaginationLoading).oldUser;
        posts.addAll(newPosts);
        yield PaginationLoaded(posts);
      }
    } catch (_) {}
  }

  Stream<PaginationState> _mapPostAddedToState(PaginationAdded event) async* {
    if (state is PaginationLoaded) {
      final List<User> updatedUsers =
          List.from((state as PaginationLoaded).users)..insert(0, event.user);
      yield PaginationLoaded(updatedUsers);
    }
  }

  Stream<PaginationState> _mapPostUpdatedToState(
      PaginationUpdated event) async* {}

  Stream<PaginationState> _mapPostDeletedToState(
      PaginationDeleted event) async* {}
}
