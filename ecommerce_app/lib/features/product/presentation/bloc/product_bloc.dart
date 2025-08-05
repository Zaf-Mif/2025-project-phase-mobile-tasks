import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';


const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUsecase getAllProducts;
  final GetProductUsecase getSingleProduct;
  final CreateProductUsecase createProduct;
  final UpdateProductUsecase updateProduct;
  final DeleteProductUsecase deleteProduct;
  final InputConverter inputConverter;

  ProductBloc({
    required GetAllProductsUsecase allProducts,
    required GetProductUsecase specific,
    required CreateProductUsecase create,
    required UpdateProductUsecase update,
    required DeleteProductUsecase delete,
    required this.inputConverter,
  })  : getAllProducts = allProducts,
        getSingleProduct = specific,
        createProduct = create,
        updateProduct = update,
        deleteProduct = delete,
        super(ProductInitialState()) {
    // Get all products
    on<GetAllProductsEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await getAllProducts();
      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (products) => emit(LoadedAllProductState(products)),
      );
    });

    // Get single product by ID
    on<GetProductByIdEvent>((event, emit) async {
      emit(ProductLoadingState());

      final inputEither = inputConverter.stringToUnsignedInteger(event.id.toString());

      if (inputEither.isLeft()) {
        emit(const ErrorState(invalidInputFailureMessage));
        return;
      }


      final id = inputEither.getOrElse(() => 0);
      final result = await getSingleProduct(id);

      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (product) => emit(LoadedSingleProductState(product!)),
      );
    });


    // Create product
    on<CreateProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await createProduct(event.product);
      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (_) => add(GetAllProductsEvent()),
      );
    });

    // Update product
    on<UpdateProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await updateProduct(event.product);
      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (_) => add(GetAllProductsEvent()),
      );
    });

    // Delete product
    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await deleteProduct(event.id);
      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (_) => add(GetAllProductsEvent()),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return serverFailureMessage;
    } else if (failure is CacheFailure) {
      return cacheFailureMessage;
    } else if (failure is InvalidInputFailure) {
      return invalidInputFailureMessage;
    } else {
      return 'Unexpected Error';
    }
  }
}
