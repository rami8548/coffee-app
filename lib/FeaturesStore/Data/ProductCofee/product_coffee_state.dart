part of 'product_coffee_cubit.dart';

@immutable
abstract class ProductCoffeeState {}

class ProductCoffeeInitial extends ProductCoffeeState {}
class ProductCoffeeLoading extends ProductCoffeeState {}
class LoadinAddCart extends ProductCoffeeState {}
class SuccessAddCart extends ProductCoffeeState {}
class SuccessRemoveCart extends ProductCoffeeState {}
class SuccessAddFavorites extends ProductCoffeeState {}
class SuccessGetFavorites extends ProductCoffeeState {}
class LoadingGetFavorites extends ProductCoffeeState {}
class SuccessDeleteFavorites extends ProductCoffeeState {}
class ProductCoffeeLoadingFilter extends ProductCoffeeState {}
class SuccessAddComments extends ProductCoffeeState {}
class SuccessGetComments extends ProductCoffeeState {}
class SuccessChangeData extends ProductCoffeeState {}
class SuccessSearchCoffee extends ProductCoffeeState {}
class SuccessAddCommentsReciver extends ProductCoffeeState {}
class SuccessGetCommentsReciver extends ProductCoffeeState {}
class LoadingGetMessageReciver extends ProductCoffeeState {}
class ErrorGetMessageReciver extends ProductCoffeeState {
  final String error;

  ErrorGetMessageReciver({required this.error});
}
class SuccessComments extends ProductCoffeeState {}

class SuccessGetCart extends ProductCoffeeState {

}
class ProductCoffeeError extends ProductCoffeeState {
  final String error;

  ProductCoffeeError({required this.error});
}
class ErrorGetCart extends ProductCoffeeState {
  final String error;

  ErrorGetCart({required this.error});
}
class ProductCoffeeSuccess extends ProductCoffeeState {}
class TotalPriceUpdated extends ProductCoffeeState {
  final double totalPrice;
  TotalPriceUpdated({required this.totalPrice});
}class ProductCoffeeTotalPriceUpdated extends ProductCoffeeState {
  final double totalPrice;

  ProductCoffeeTotalPriceUpdated({required this.totalPrice});
}

class ProductCoffeeQuantityUpdated extends ProductCoffeeState {}