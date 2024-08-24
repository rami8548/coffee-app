import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Register/Model/UserModel.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  static HomeScreenCubit get(context) => BlocProvider.of(context);
  List<UserModel> getAllUser = [];

  void getUser() async {
    emit(LoadingGetAllUser());
    try {
   FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
     getAllUser.clear();
     for (var item in event.docs) {
       if(item.id!=CacheHelper.getData(key: "idUser")){
         getAllUser.add(UserModel.fromJson(item.data()));

       }
           }
           emit(SuccessGetAllUser());
         },
   );
   

    } catch (e) {
      emit(ErrorGetAllUser(error: e.toString()));
    }
  }
  List<UserModel> getSearch = [];

  void searchUser(String query){
  getSearch=  getAllUser.where((element) {
     return element.name.toLowerCase().startsWith(query.toLowerCase());
    },).toList();
  emit(SuccessSearch());
  }
  void logOut()async{
    await FirebaseAuth.instance.signOut();
    emit(SuccessLogOut());

  }
}
