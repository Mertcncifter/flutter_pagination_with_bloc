part of 'pagination_bloc.dart';

abstract class PaginationEvent extends Equatable {
  const PaginationEvent();
  @override
  List<Object> get props => [];
}

class PaginationPageRequest extends PaginationEvent {}

class PaginationAdded extends PaginationEvent {
  final User user;
  const PaginationAdded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'PaginationAdded {Pagination:$user}';
}

class PaginationUpdated extends PaginationEvent {
  final User user;
  const PaginationUpdated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'PaginationUpdated {Pagination:$user}';
}

class PaginationDeleted extends PaginationEvent {
  final User user;
  const PaginationDeleted(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'PaginationDeleted {Pagination:$user}';
}

class ClearCompleted extends PaginationEvent {}

class PaginationAll extends PaginationEvent {}
