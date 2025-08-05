import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockGetAllProductsUsecase extends Mock implements GetAllProductsUsecase {}

class MockGetProductUsecase extends Mock implements GetProductUsecase {}

class MockCreateProductUsecase extends Mock implements CreateProductUsecase {}

class MockUpdateProductUsecase extends Mock implements UpdateProductUsecase {}

class MockDeleteProductUsecase extends Mock implements DeleteProductUsecase {}

class MockInputConverter extends Mock implements InputConverter {}

class FakeProduct extends Fake implements Product {}

void main() {
  late ProductBloc bloc;
  late MockGetAllProductsUsecase mockGetAllProductsUsecase;
  late MockGetProductUsecase mockGetProductUsecase;
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockInputConverter mockInputConverter;

  setUpAll(() {
    registerFallbackValue(FakeProduct());
  });

  setUp(() {
    mockGetAllProductsUsecase = MockGetAllProductsUsecase();
    mockGetProductUsecase = MockGetProductUsecase();
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    mockInputConverter = MockInputConverter();

    bloc = ProductBloc(
      allProducts: mockGetAllProductsUsecase,
      specific: mockGetProductUsecase,
      create: mockCreateProductUsecase,
      update: mockUpdateProductUsecase,
      delete: mockDeleteProductUsecase,
      inputConverter: mockInputConverter, 
    );
  });
  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(ProductInitialState()));
  }); 

  const tProduct = Product(
    id: 1,
    name: 'Test Product',
    description: 'A test product',
    price: 10.0,
    imageUrl: 'test.png',
  );

  final tProductList = [tProduct];

  group('GetAllProductsEvent', () {
    blocTest<ProductBloc, ProductState>(
      'should return list of products when call is successful',
      // Arrange
      build: () {
        when(() => mockGetAllProductsUsecase())
            .thenAnswer((_) async => Right(tProductList));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(GetAllProductsEvent()),
      // Assert
      expect: () => [
        ProductLoadingState(),
        LoadedAllProductState(tProductList),
      ],
      verify: (_) => verify(() => mockGetAllProductsUsecase()).called(1),
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [Loading, Error] when fetching all fails',
      // Arrange
      build: () {
        when(() => mockGetAllProductsUsecase())
            .thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(GetAllProductsEvent()),
      // Assert
      expect: () => [
        ProductLoadingState(),
        const ErrorState(serverFailureMessage),
      ],
    );
  });

  group('GetProductByIdEvent', () {
    const tId = 1;

    blocTest<ProductBloc, ProductState>(
      'should return single product when call is successful',
      // Arrange
      build: () {
        when(() => mockInputConverter.stringToUnsignedInteger(any()))
            .thenReturn(const Right(tId));
        when(() => mockGetProductUsecase(tId))
            .thenAnswer((_) async => const Right(tProduct));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const GetProductByIdEvent(tId)),
      // Assert
      expect: () => [
        ProductLoadingState(),
        const LoadedSingleProductState(tProduct),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [Loading, Error] when input is invalid',
      // Arrange
      build: () {
        when(() => mockInputConverter.stringToUnsignedInteger(any()))
            .thenReturn(Left(InvalidInputFailure()));
        return bloc;
      },
      // Act 
      act: (bloc) => bloc.add(const GetProductByIdEvent(-1)),
      // Assert
      expect: () => [
        ProductLoadingState(),
        const ErrorState(invalidInputFailureMessage),
      ],
    );
  });

  group('CreateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'should emit [Loading, LoadedAllProductState] when product is created successfully',
      // Arrange
      build: () {
        when(() => mockCreateProductUsecase(any()))
            .thenAnswer((_) async => const Right(unit)); // create returns unit on success

        // Mock the GetAllProductsUsecase to respond to the triggered event
        when(() => mockGetAllProductsUsecase())
            .thenAnswer((_) async => Right(tProductList));

        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CreateProductEvent(tProduct)),
      // Assert
      expect: () => [
        ProductLoadingState(),
        LoadedAllProductState(tProductList),  // After creation, bloc loads all products
      ],
    );
  });


  group('UpdateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'should emit [Loading, LoadedAllProductState] when product is updated successfully',
      // Arrange
      build: () {
        when(() => mockUpdateProductUsecase(any()))
            .thenAnswer((_) async => const Right(unit));  // update returns unit on success

        // IMPORTANT: mock GetAllProductsUsecase because the bloc triggers GetAllProductsEvent internally
        when(() => mockGetAllProductsUsecase())
            .thenAnswer((_) async => Right(tProductList));

        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const UpdateProductEvent(tProduct)),
      // Assert
      expect: () => [
        ProductLoadingState(),
        LoadedAllProductState(tProductList),  // Because the bloc loads all products after update
      ],
    );
  });

  group('DeleteProductEvent', () {
    const tId = 1;
    final tProducts = <Product>[]; // You can replace with mock products later

    blocTest<ProductBloc, ProductState>(
      'should emit [Loading, LoadedAllProductState] when product is deleted successfully',
      // Arrange
      build: () {
        when(() => mockDeleteProductUsecase(tId))
            .thenAnswer((_) async => const Right(unit));
        when(() => mockGetAllProductsUsecase())
            .thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const DeleteProductEvent(tId)),
      // Assert
      expect: () => [
        ProductLoadingState(),
        LoadedAllProductState(tProducts),
      ],
    );
  });

}
