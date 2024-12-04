part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}
final class DashboardSuccess extends DashboardState {
 final  List<DashboardModel> dashboardList;

  DashboardSuccess({required this.dashboardList});
}
final class DashboardError extends DashboardState {}
