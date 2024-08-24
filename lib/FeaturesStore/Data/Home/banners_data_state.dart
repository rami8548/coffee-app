part of 'banners_data_cubit.dart';

@immutable
abstract class BannersDataState {}

class BannersDataInitial extends BannersDataState {}
class SuccessGetBanners extends BannersDataState {}
class LoadingGetBanners extends BannersDataState {}
class SuccessChangeFavorite extends BannersDataState {}
class LoadingGetFavorite extends BannersDataState {}
class SuccessGetFavorite extends BannersDataState {}
class SuccessAddFavorite extends BannersDataState {}
class SuccessChangeIsSearch extends BannersDataState {}
class LoadingGetCategoryId extends BannersDataState {}
class SuccessGetCategoryId extends BannersDataState {}
class SuccessDeleteFavorite extends BannersDataState {}
class ErrorGetBanners extends BannersDataState {
  final String error;

  ErrorGetBanners({required this.error});
}
class ErrorGetCategoryId extends BannersDataState {
  final String error;

  ErrorGetCategoryId({required this.error});
}
class ErrorDeleteFavorite extends BannersDataState {
  final String error;

  ErrorDeleteFavorite({required this.error});
}
class ErrorrAddFavorite extends BannersDataState {
  final String error;

  ErrorrAddFavorite({required this.error});
}
class ErrorGetFavorite extends BannersDataState {
  final String error;

  ErrorGetFavorite({required this.error});
}
class SuccessGetCategory extends BannersDataState {}
class LoadingGetCategory extends BannersDataState {}
class ErrorGetCategory extends BannersDataState {
  final String error;

  ErrorGetCategory({required this.error});
}