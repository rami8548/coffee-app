
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Model/bannersModel.dart';
import 'package:meta/meta.dart';

part 'banners_data_state.dart';

class BannersDataCubit extends Cubit<BannersDataState> {
  BannersDataCubit() : super(BannersDataInitial());

  static BannersDataCubit get(context) => BlocProvider.of(context);
  List<BannersModel> listBanners = [];
bool isSearch=false;
void changeSearch(){
  isSearch=!isSearch;
  emit(SuccessChangeIsSearch());
}
  void getBanners() async {
    emit(LoadingGetBanners());
    // await FirebaseFirestore.instance.collection("banners").get().then(
    //       (value) {
    //     for (var item in value.docs) {
    //       listBanners.add(BannersModel.fromJson(item.data()));
    //     }
    //     print(value);
    //     debugPrint("length isbanners ${listBanners.length}");
    //     emit(SuccessGetBanners());
    //   },
    // ).catchError(
    //     (e){
    //       print(e.toString());
    //       emit(ErrorGetBanners(error:e.toString()));
    //     }
    // );
    await FirebaseFirestore.instance.collection("banners").get().then(
      (value) {
        for (var item in value.docs) {
          listBanners.add(BannersModel.fromJson(item.data()));
        }
        debugPrint("length is ${listBanners.length}");
        emit(SuccessGetBanners());
      },
    ).catchError( (e){
      emit(ErrorGetBanners(error: e.toString()));
    });
  }

  List<BannersModel> listCategory = [];

  void getCategory() async {
    emit(LoadingGetCategory());
    try {
      await FirebaseFirestore.instance
          .collection("cagetory")
          .snapshots()
          .listen(
        (value) {
          listCategory.clear();
          for (var item in value.docs) {
            listCategory.add(BannersModel.fromJson(item.data()));
          }
          debugPrint("length is ${listCategory.length}");
          emit(SuccessGetCategory());
        },
      );
    } catch (e) {
      print(e.toString());
      emit(ErrorGetCategory(error: e.toString()));
    }
  }

  List<ProductModel> listCategoryId = [];
  void getCategoryId(String id) async {
    emit(LoadingGetCategoryId());

    try {
      await FirebaseFirestore.instance
          .collection("cagetory")
          .doc(id)
          .collection("type")
          .snapshots()
          .listen(
        (value) {
          listCategoryId.clear();

          for (var item in value.docs) {
            listCategoryId.add(ProductModel.fromJson(item.data()));
          }
          debugPrint("length is ${listCategoryId.length}");
          emit(SuccessGetCategoryId());
        },
      );
    } catch (e) {
      print(e.toString());
      emit(ErrorGetCategoryId(error: e.toString()));
    }
  }


}
