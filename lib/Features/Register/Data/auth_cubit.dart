import 'dart:io';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:path/path.dart' as Path;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  void register({
    required String emailAddress,
    required String password,
    required String name,
    // required String name,
  }) async {
    emit(RegisterLoading());
    try {
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      var id=await CacheHelper.saveData(key: "idUser", value: credential.user!.uid);
      print("CacheHelper is${CacheHelper.getData(key: "idUser")}");
      String imageUrl = await uploadImageToFirebase();

      debugPrint("the id is${credential.user!.uid}");
      debugPrint("the id is${imageUrl}");
      uploadDataUserModelIntoCloudStore(
          name: name,
          id: credential.user!.uid,
          email: emailAddress,
          password: password,
          url: imageUrl);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      emit(RegisterError(error: e.toString()));
    }
  }


void logIn({
    required String email,
    required String passWord,
}) async{
    emit(LoadingLogIn());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: passWord
      );
      await CacheHelper.saveData(key: "idUser", value:credential.user!.uid );
      print(credential.user!.uid.toString());
      emit(SuccessLogIn());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       emit(ErrorLogIn(error: e.toString()));
      } else if (e.code == 'wrong-password') {
        emit(ErrorLogIn(error: e.toString()));
      }
    }
}
  bool isObscure = false;
void upDateUserData(String id, String name)async{
  await FirebaseFirestore.instance.collection("users").doc(id).update({
"name":name,
  }).then((value) {
    emit(SuccessUpdateDataUser());
  },);
}
  void changeIcon() {
    isObscure = !isObscure;
    emit(SuccessChangeIcon());
  }

  File? imageFile;

  void selectImage() async {
    var picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null) {
      imageFile = File(picker.path);
      emit(SuccessSelectImage());
    }
  }

  File? imageFile2;

  void selectImageUpdate() async {
    var picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null) {
      imageFile = File(picker.path);
      emit(SuccessSelectImageUpdate());
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

  void uploadDataUserModelIntoCloudStore({
    required String name,
    required String url,
    required String email,
    required String password,
    required String id,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(id).set({
      "name": name,
      "image": url,
      "email": email,
      "password": password,
      "id": id,
    });
  }
  void changePassword(String currentPassword, String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(ErrorChangePassWord(error: "User not authenticated"));
        return;
      }

      final cred = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);

      emit(SuccesChangePassWord());
    } catch (error) {
      emit(ErrorChangePassWord(error: error.toString()));
    }
  }

}
