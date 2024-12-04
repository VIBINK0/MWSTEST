import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sampletest/data/models/dashboard_model.dart';
import 'package:sampletest/data/view_models/dashboard_view_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  List<DashboardModel> dashboardModel = [];
  List<DashboardModel> filterDashboardModel = [];

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEventGetData>(onDashboardEventGetData);
    on<DashboardEventOnSearchEvent>(onDashboardEventOnSearchEvent);
  }

  FutureOr<void> onDashboardEventGetData(DashboardEventGetData event, Emitter<DashboardState> emit) async{
    emit(DashboardLoading());
    final response = await DashboardViewModel.getDashboardData();
    if(response!=null){
      dashboardModel = response;
      filterDashboardModel = response;
      emit(DashboardSuccess(dashboardList: response));
    }else{
      emit(DashboardError());
    }
  }



  FutureOr<void> onDashboardEventOnSearchEvent(DashboardEventOnSearchEvent event, Emitter<DashboardState> emit) {
    if(event.query.isNotEmpty){
       List<DashboardModel> queryModel = filterDashboardModel.where((e) => e.name!.contains(event.query)).toList();
       emit(DashboardSuccess(dashboardList: queryModel));
    }else{
      emit(DashboardSuccess(dashboardList: dashboardModel));
    }
  }
}
