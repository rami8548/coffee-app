part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class RegisterSuccess extends AuthState {}
class RegisterLoading extends AuthState {}
class SuccessChangeIcon extends AuthState {}
class SuccessUpdateDataUser extends AuthState {}
class SuccessSelectImage extends AuthState {}
class SuccessSelectImageUpdate extends AuthState {}
class SuccesChangePassWord extends AuthState {}
class ErrorChangePassWord extends AuthState {
  final String error;

  ErrorChangePassWord({required this.error});
}
class LoadingLogIn extends AuthState {}
class ErrorLogIn extends AuthState {
  final String error;

  ErrorLogIn({required this.error});
}
class SuccessLogIn extends AuthState {}
class RegisterError extends AuthState {
  final String error;

  RegisterError({required this.error});
}
