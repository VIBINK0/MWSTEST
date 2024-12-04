part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}


class DashboardEventGetData extends DashboardEvent{}

class DashboardEventOnSearchEvent extends DashboardEvent{
  final String query;

  DashboardEventOnSearchEvent({required this.query});
}