part of 'pagination_bloc.dart';

abstract class PaginationState extends Equatable {
  const PaginationState() : super();

  @override
  List<Object> get props => [];
}

class PaginationInitial extends PaginationState {}

class PaginationLoaded extends PaginationState {
  final List<User> users;
  PaginationLoaded(this.users);
  @override
  List<Object> get props => [users];

  @override
  String toString() => 'PaginationLoaded {Pagination: $users}';
}

class PaginationLoading extends PaginationState {
  final List<User> oldUser;
  final bool isFirstFetch;
  const PaginationLoading(this.oldUser, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldUser, isFirstFetch];

  @override
  String toString() =>
      'PaginationLoading {oldPagination: $oldUser,isFirstFetch : $isFirstFetch}';
}

class PaginationLoadFailure extends PaginationState {}
