part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}
class SuccessGetAllUser extends HomeScreenState {}
class LoadingGetAllUser extends HomeScreenState {}
class SuccessSearch extends HomeScreenState {}
class SuccessLogOut extends HomeScreenState {}
class ErrorGetAllUser extends HomeScreenState {
  final String error;

  ErrorGetAllUser({required this.error});
}
