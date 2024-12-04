import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampletest/blocs/dashbard_bloc/dashboard_bloc.dart';
import 'package:sampletest/data/models/dashboard_model.dart';
import 'package:sampletest/helper/app_colors.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

 late DashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    _dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    _dashboardBloc.add(DashboardEventGetData());
  }

  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery(data: data, child: child)
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.appWhite,
          appBar:showSearch ?  _appSearchField() : _appBar(),
          body: _bodyView(context,state),
        );
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
          backgroundColor: AppColors.appBlack,
          title: Text('MWS',
            style: TextStyle(color: AppColors.appWhite, fontSize: 20),),
          actions: [
            IconButton(onPressed: () {
              setState(() {
                showSearch = true;
              });
            },
                icon: Icon(Icons.search, color: AppColors.appWhite,))
          ],
        );
  }

  AppBar _appSearchField(){
     return AppBar(
       backgroundColor: AppColors.appBlack,
       title: Padding(
         padding: const EdgeInsets.symmetric(vertical: 10.0),
         child: TextField(
           decoration: InputDecoration(
             border: UnderlineInputBorder(
               borderSide: BorderSide(color: AppColors.appWhite)
             ),
             hintText: 'Search..',
             hintStyle: TextStyle(color: AppColors.appWhite),
            suffixIcon: IconButton(onPressed: (){
              setState(() {
                showSearch = false;
              });
              _dashboardBloc.add(DashboardEventOnSearchEvent(query: ''));
            }, icon: Icon(Icons.close,color: Colors.white,))
           ),
           style: TextStyle(color: AppColors.appWhite),

           onChanged: (val){
             _dashboardBloc.add(DashboardEventOnSearchEvent(query: val));
           },
         ),
       ),
     );
  }

  Widget _bodyView(BuildContext context, DashboardState state) {
     if(state is DashboardSuccess){
        if(state.dashboardList.isEmpty){
          return const Center(child: Text("NO DATA !",style: TextStyle(fontSize: 16),),);
        }
       return _dashboardListView(context,state);
     }
     else if(state is DashboardLoading){
       return const Center(child: CircularProgressIndicator(),);
     }
     return const SizedBox();
  }

  Widget _dashboardListView(BuildContext context, DashboardSuccess state) {
     return ListView.builder(
       padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
         itemCount:  state.dashboardList.length,
         itemBuilder: (context,i){
           return _dashBoardCard(state.dashboardList[i]);
         }
     );
  }

  Widget _dashBoardCard(DashboardModel dashboardList) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.appWhite,
          borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(color: Colors.black26,blurRadius: 0.2,spreadRadius: 0.2),
          const BoxShadow(color: Colors.black26,blurRadius: 0.2,spreadRadius: 0.2),
        ]
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(dashboardList.imageLink!,fit: BoxFit.cover,)),
          Text(dashboardList.name!,style: const TextStyle(fontSize: 16),textAlign: TextAlign.center,),
          const SizedBox(height: 10,),
          Text(dashboardList.brand!,style: const TextStyle(fontSize: 16),textAlign: TextAlign.center,),
          const SizedBox(height: 10,),
          Text("Rs ${dashboardList.price!}/-",style: const TextStyle(fontSize: 18),textAlign: TextAlign.center,),
          const SizedBox(height: 10,),
          Text("Rs ${dashboardList.description!}/-",style: const TextStyle(fontSize: 18),textAlign: TextAlign.center,maxLines: 2,),
        ],
      ),
    );
  }
}
