part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}
class SuccessAddProduct extends AddProductState {}
class SuccessSelectImageProduct extends AddProductState {}
class ErrorAddProduct extends AddProductState {
  final String error;

  ErrorAddProduct({required this.error});
}
