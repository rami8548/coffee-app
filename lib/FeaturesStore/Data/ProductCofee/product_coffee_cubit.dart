import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Register/Model/UserModel.dart';
import 'package:food/FeaturesStore/Model/CategoryModel.dart';
import 'package:food/FeaturesStore/Model/MessageModel.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:meta/meta.dart';

part 'product_coffee_state.dart';

class ProductCoffeeCubit extends Cubit<ProductCoffeeState> {
  ProductCoffeeCubit() : super(ProductCoffeeInitial());

  static ProductCoffeeCubit get(context) => BlocProvider.of(context);
  List<ProductModel> listProduct = [];
  List<ProductModel> searchProduct = [];
  Set<String> idSets = {};
  List<ProductModel> cart = [];
  double totalPrice = 0.0;

  void getProduct() async {
    emit(ProductCoffeeLoading());
    listProduct.clear();
    await FirebaseFirestore.instance
        .collection("productCoffe")
        .snapshots()
        .listen((value) {
      for (var item in value.docs) {
        listProduct.add(ProductModel.fromJson(item.data()));
      }
      debugPrint("the length product ${listProduct.length}");
      emit(ProductCoffeeSuccess());
    });
  }
  void getProductSearch(int price) async {
    emit(ProductCoffeeLoadingFilter());
    searchProduct.clear();
     FirebaseFirestore.instance
        .collection("productCoffe").where("price",isGreaterThanOrEqualTo: price)
        .snapshots()
        .listen((value) {
      for (var item in value.docs) {
        searchProduct.add(ProductModel.fromJson(item.data()));
      }
      debugPrint("the length product ${searchProduct.length}");
      emit(SuccessSearchCoffee());
    });
  }

//   void searchCofee(String name){
//   searchProduct=  listProduct.where((element) {
//      return element.name.toLowerCase().toString().startsWith(name.toString());
//     },).toList();
//   emit(SuccessSearchCoffee());
// }
  void addAndRemoveCart({
    required String id,
    required String imageUrl,
    required String name,
    required String flavorNotes,
    required num price,
    required num review,
    required String description,
    required String iddoc,
    required String caffeineContent,
    required List<String> contains,
    required List<String> ingredients,
    required List<String> sizes,
    required List<String> origin,
  required String iduser
  }) async {
    ProductModel categoryModel = ProductModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      review: review,
      flavorNotes: flavorNotes,
      origin: origin,
      ingredients: ingredients,
      caffeineContent: caffeineContent,
      sizes: sizes,
      contains: contains,

    );

    if (idSets.contains(iddoc)) {
      idSets.remove(iddoc);
      await FirebaseFirestore.instance.collection("user").doc(iduser).collection("cart").doc(iddoc).delete();
    } else {
      idSets.add(iddoc);
      await FirebaseFirestore.instance.collection("user").doc(iduser)
          .collection("cart")
          .doc(iddoc)
          .set(categoryModel.toJson());
    }
    debugPrint("the length is cart: ${idSets.length}");
    emit(SuccessAddCart());
    calculateTotalPrice(); // Recalculate total price after adding/removing item
  }

  void getCart(String id) async {
    emit(LoadinAddCart());
    FirebaseFirestore.instance.collection("user").doc(id).collection("cart").snapshots().listen((value) {
      cart.clear();
      for (var item in value.docs) {
        cart.add(ProductModel.fromJson(item.data()));
        idSets.add(item["id"]);
      }
      emit(SuccessGetCart());
      calculateTotalPrice(); // Recalculate total price after fetching cart items
    });
  }

  void calculateTotalPrice() {
    totalPrice =
        cart.fold(0.0, (sum, item) => sum + item.price * item.quantity!);
    emit(ProductCoffeeTotalPriceUpdated(totalPrice: totalPrice));
  }

  void incrementQuantity(String productId) {
    final index = cart.indexWhere((item) => item.id == productId);
    if (index != -1) {
      cart[index].quantity = cart[index].quantity! + 1;
      calculateTotalPrice();
      emit(ProductCoffeeQuantityUpdated());
    }
  }

  void decrementQuantity(String productId) {
    final index = cart.indexWhere((item) => item.id == productId);
    if (index != -1 && cart[index].quantity! > 1) {
      cart[index].quantity = cart[index].quantity! - 1;
      calculateTotalPrice();
      emit(ProductCoffeeQuantityUpdated());
    }
  }

  void removeFromCart(String productId,String idUser) async {
    await FirebaseFirestore.instance.collection("user").doc(idUser).collection("cart").doc(productId).delete();
    cart.removeWhere(
        (item) => item.id == productId); // Remove item from cart list
    idSets.remove(productId);
    calculateTotalPrice();
    emit(SuccessRemoveCart());
  }

  void addAndRemoveFavorite({
    required String id,
    required String imageUrl,
    required String name,
    required String flavorNotes,
    required num price,
    required num review,
    required String description,
    required String caffeineContent,
    required List<String> contains,
    required List<String> ingredients,
    required List<String> sizes,
    required List<String> origin,
    required String idUser,

  }) async {
    ProductModel categoryModel = ProductModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      review: review,
      flavorNotes: flavorNotes,
      origin: origin,
      ingredients: ingredients,
      caffeineContent: caffeineContent,
      sizes: sizes,
      contains: contains,
    );
    // await FirebaseFirestore.instance.collection("favorites").doc(id).set(categoryModel.toJson());

    if (idFavoriteProduct.contains(id)) {
      idFavoriteProduct.remove(id);
      await FirebaseFirestore.instance.collection("user").doc(idUser).collection("favorites").doc(id).delete();
    } else {
      idFavoriteProduct.add(id);
      await FirebaseFirestore.instance.collection("user").doc(idUser)
          .collection("favorites")
          .doc(id)
          .set(categoryModel.toJson());
    }
    debugPrint("the length chche is favorite: ${idFavoriteProduct.length}");
    emit(SuccessAddFavorites());
  }

  List<ProductModel> favorites = [];
  Set<String> idFavoriteProduct = {};

  void getFavorite(String id) async {
    emit(LoadingGetFavorites());
    FirebaseFirestore.instance.collection("user").doc(id)
        .collection("favorites")
        .snapshots()
        .listen((value) {
      favorites.clear();
      for (var item in value.docs) {
        favorites.add(ProductModel.fromJson(item.data()));
        idFavoriteProduct.add(item["id"]);
      }
      emit(SuccessGetFavorites());
    });
  }

  void deletfavorite(String id,String idUser) async {
    await FirebaseFirestore.instance.collection("user").doc(idUser).collection("favorites").doc(id).delete();
    idFavoriteProduct.remove(id);
    emit(SuccessDeleteFavorites());
  }

  List<CategoryModel> commentsList = [];

  void addComment({
    required String senderId,
    required String id,
    required String age,
    required String name,
    required String image,
    required String content,
  }) async {
    CategoryModel categoryModel = CategoryModel(
        id: id,
        imageUrl: image,
        name: name,
        content: content,
        age: age,
        senderId: senderId,
        date: DateTime.now().toString());

    await FirebaseFirestore.instance
        .collection("comments")
        .doc(id)
        .collection("com")
        .doc(senderId)
        .set(categoryModel.toJson());
    emit(SuccessAddComments());
  }

  void getComment(String id) async {
    FirebaseFirestore.instance
        .collection("comments")
        .doc(id)
        .collection("com")
        .snapshots()
        .listen((event) {
      commentsList.clear();
      for (var item in event.docs) {
        commentsList.add(CategoryModel.fromJson(item.data()));
      }
      emit(SuccessGetComments());
    });
  }

  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  UserModel? userModel;

  void getDataUser() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(CacheHelper.getData(key:"idUser"))
        .snapshots()
        .listen((event) {
      userModel = UserModel.fromJson(event.data()!);
      emit(SuccessChangeData());
      debugPrint("the username ${userModel!.name.toString()}");
    });
  }

  void addCommentReciver({
    required String senderId,
    required String id,
    required String age,
    required String name,
    required String image,
    required String reciverId,
    required String content,
  }) async {
    Messagemodel categoryModel = Messagemodel(
      id: id,
      recieverId: reciverId,
      imageUrl: image,
      name: name,
      content: content,
      age: age,
      senderId: senderId,
      date: DateTime.now().toString(),
    );

    await FirebaseFirestore.instance
        .collection("comments")
        .doc(id)
        .collection("com")
        .doc(senderId).collection("reciever").doc(reciverId)
        .collection("reciverMessage")

        .add(categoryModel.toJson());
    emit(SuccessAddCommentsReciver());
  }
  List<Messagemodel> commentsListReciver = [];


  void getCommentReciver(String id, String idUser) async {
    FirebaseFirestore.instance
        .collection("comments")
        .doc(id)
        .collection("com")
        .doc(idUser)
        .collection("reciever").doc(idUser).collection("reciverMessage")
        .snapshots()
        .listen((event) {
          commentsListReciver.clear();
      for (var item in event.docs) {
        commentsListReciver.add(Messagemodel.fromJson(item.data()));
      }      emit(SuccessGetCommentsReciver());


    });
  }
}
