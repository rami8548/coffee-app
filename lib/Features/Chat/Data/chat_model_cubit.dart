import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Chat/Model/ChatModel.dart';
import 'package:meta/meta.dart';

part 'chat_model_state.dart';

class ChatModelCubit extends Cubit<ChatModelState> {
  ChatModelCubit() : super(ChatModelInitial());

  static ChatModelCubit get(context) => BlocProvider.of(context);

  void sendMessage({required String message, required String senderId}) async {
    final userId = CacheHelper.getData(key: "idUser");


    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("chat")
        .doc(senderId)
        .collection("message")
        .add({
      "content": message,
      "time": DateTime.now().toString(),
      "senderId": userId,
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(senderId)
        .collection("chat")
        .doc(userId)
        .collection("message")
        .add({
      "content": message,
      "time": DateTime.now().toString(),
      "senderId": userId,
    });

    emit(SuccessUpload());
  }

  List<ChatModel> getmessage = [];

  void getMessageAll(String senderId) async {
    final userId = CacheHelper.getData(key: "idUser");

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("chat")
        .doc(senderId)
        .collection("message").orderBy("time")
        .snapshots()
        .listen((event) {
      getmessage.clear();
      for (var item in event.docs) {
        getmessage.add(ChatModel.fromJson(item.data()));
      }
      emit(SuccessGetMessage());
    });

    print("Length is ${getmessage.length}");
  }
}
