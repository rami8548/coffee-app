part of 'chat_model_cubit.dart';

@immutable
abstract class ChatModelState {}

class ChatModelInitial extends ChatModelState {}
class SuccessUpload extends ChatModelState {}
class SuccessGetMessage extends ChatModelState {}
