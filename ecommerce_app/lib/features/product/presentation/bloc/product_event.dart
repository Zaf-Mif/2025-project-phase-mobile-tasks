part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable{
  const ProductEvent();

  @override
  List<Object?> get props => [];
}
// 5 events because the app supports CRUD 
// Read All
class GetAllProductsEvent extends ProductEvent{}

// READ ONE (requires an ID)
class GetProductByIdEvent extends ProductEvent{
  final int id;

  const GetProductByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// CREATE new product 
class CreateProductEvent extends ProductEvent{
  final Product product;

  const CreateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

// UPDATE an existing product
class UpdateProductEvent extends ProductEvent{
  final Product product;

  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

//  DELETE a product 
class DeleteProductEvent extends ProductEvent{
  final int id;

  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}
