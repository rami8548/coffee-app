import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  void addProduct({
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
  }) async {


await FirebaseFirestore.instance.collection("productCoffe").add({
  "name": name,
  "description": description,
  "imageUrl": imageUrl,
  "price": price,
  "review": review,
  "flavorNotes": flavorNotes,
  "origin": origin,
  "ingredients": ingredients,
  "caffeineContent": caffeineContent,
  "sizes": sizes,
  "contains": contains,
}).then((value) {
  emit(SuccessAddProduct());
},).catchError( (e){
  emit(ErrorAddProduct(error:e.toString()));
});// Recalculate total price after adding/removing item
  }
  File? imageFile;

  void selectImage() async {
    var picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null) {
      imageFile = File(picker.path);
      emit(SuccessSelectImageProduct());
    }
  }
  Future<String> uploadImageToFirebase() async {
    try {
      String fileName = basename(imageFile!.path);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref(fileName);
      await firebaseStorageRef.putFile(imageFile!);
      String downloadUrl = await firebaseStorageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      throw Exception("Failed to upload image.");
    }
  }
}
