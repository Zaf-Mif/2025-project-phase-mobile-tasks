import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_data_sources.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes for dependencies
class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}
class MockLocalDataSource extends Mock implements ProductLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  // Register fallback value for ProductModel so `any<ProductModel>()` works in mocktail
  setUpAll(() {
    registerFallbackValue(const ProductModel(
      id: 0,
      name: '',
      price: 0.0,
      imageUrl: '',
      description: '',
    ));
  });

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tProductModel = ProductModel(
    id: 1,
    name: 'Laptop',
    price: 1500.0,
    imageUrl: 'https://image.url/laptop.jpg',
    description: 'High-end gaming laptop',
  );

  final tProductList = [tProductModel];
  final tProductEntities = tProductList.map((e) => e.toEntity()).toList();

  // Helper to run tests in online mode
  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  // Helper to run tests in offline mode
  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  // Tests for getAllProducts()
  group('getAllProducts', () {
    test('should check if the device is online', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => tProductList);
      when(() => mockLocalDataSource.cacheProducts(any()))
          .thenAnswer((_) async => {});

      // Act
      await repository.getAllProducts();

      // Assert
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runTestsOnline(() {
      test('should return remote products when remote call is successful', () async {
        when(() => mockRemoteDataSource.getAllProducts())
            .thenAnswer((_) async => tProductList);
        when(() => mockLocalDataSource.cacheProducts(any()))
            .thenAnswer((_) async => {});

        final result = await repository.getAllProducts();

        expect(result, Right(tProductEntities));
        verify(() => mockRemoteDataSource.getAllProducts()).called(1);
        verify(() => mockLocalDataSource.cacheProducts(tProductList)).called(1);
      });

      test('should return ServerFailure when remote call throws an exception', () async {
        when(() => mockRemoteDataSource.getAllProducts()).thenThrow(Exception());

        final result = await repository.getAllProducts();

        expect(result, const Left(ServerFailure()));
        verify(() => mockRemoteDataSource.getAllProducts()).called(1);
        verifyNever(() => mockLocalDataSource.cacheProducts(any()));
      });
    });

    runTestsOffline(() {
      test('should return cached products when local call is successful', () async {
        when(() => mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => tProductList);

        final result = await repository.getAllProducts();

        expect(result, Right(tProductEntities));
        verifyNever(() => mockRemoteDataSource.getAllProducts());
        verify(() => mockLocalDataSource.getCachedProducts()).called(1);
      });

      test('should return CacheFailure when local call throws an exception', () async {
        when(() => mockLocalDataSource.getCachedProducts())
            .thenThrow(Exception());

        final result = await repository.getAllProducts();

        expect(result, const Left(CacheFailure()));
        verify(() => mockLocalDataSource.getCachedProducts()).called(1);
      });
    });
  });

  // Tests for getProductById()
  group('getProductById', () {
    test('should return product when remote call is successful', () async {
      when(() => mockRemoteDataSource.getProductById(1))
          .thenAnswer((_) async => tProductModel);

      final result = await repository.getProductById(1);

      expect(result, Right(tProductModel.toEntity()));
      verify(() => mockRemoteDataSource.getProductById(1)).called(1);
    });

    test('should return ServerFailure when remote call throws an exception', () async {
      when(() => mockRemoteDataSource.getProductById(1))
          .thenThrow(Exception());

      final result = await repository.getProductById(1);

      expect(result, const Left(ServerFailure()));
      verify(() => mockRemoteDataSource.getProductById(1)).called(1);
    });
  });

  // Tests for createProduct()
  group('createProduct', () {
    test('should return void when product is created remotely and locally successfully', () async {
      when(() => mockRemoteDataSource.createProduct(any()))
          .thenAnswer((_) async => {});
      when(() => mockLocalDataSource.saveProduct(any()))
          .thenAnswer((_) async => {});

      final result = await repository.createProduct(tProductModel.toEntity());

      expect(result, const Right(null));
      verify(() => mockRemoteDataSource.createProduct(tProductModel)).called(1);
      verify(() => mockLocalDataSource.saveProduct(tProductModel)).called(1);
    });

    test('should return ServerFailure when remote creation throws an exception', () async {
      when(() => mockRemoteDataSource.createProduct(any()))
          .thenThrow(Exception());

      final result = await repository.createProduct(tProductModel.toEntity());

      expect(result, const Left(ServerFailure()));
      verify(() => mockRemoteDataSource.createProduct(any())).called(1);
      verifyNever(() => mockLocalDataSource.saveProduct(any()));
    });
  });

  // Tests for updateProduct()
  group('updateProduct', () {
    test('should return void when product is updated remotely and locally successfully', () async {
      when(() => mockRemoteDataSource.updateProduct(any()))
          .thenAnswer((_) async => {});
      when(() => mockLocalDataSource.updateProduct(any()))
          .thenAnswer((_) async => {});

      final result = await repository.updateProduct(tProductModel.toEntity());

      expect(result, const Right(null));
      verify(() => mockRemoteDataSource.updateProduct(tProductModel)).called(1);
      verify(() => mockLocalDataSource.updateProduct(tProductModel)).called(1);
    });

    test('should return ServerFailure when remote update throws an exception', () async {
      when(() => mockRemoteDataSource.updateProduct(any()))
          .thenThrow(Exception());

      final result = await repository.updateProduct(tProductModel.toEntity());

      expect(result, const Left(ServerFailure()));
      verify(() => mockRemoteDataSource.updateProduct(any())).called(1);
      verifyNever(() => mockLocalDataSource.updateProduct(any()));
    });
  });

  // Tests for deleteProduct()
  group('deleteProduct', () {
    test('should return void when product is deleted remotely and locally successfully', () async {
      when(() => mockRemoteDataSource.deleteProduct(1))
          .thenAnswer((_) async => {});
      when(() => mockLocalDataSource.deleteProduct(1))
          .thenAnswer((_) async => {});

      final result = await repository.deleteProduct(1);

      expect(result, const Right(null));
      verify(() => mockRemoteDataSource.deleteProduct(1)).called(1);
      verify(() => mockLocalDataSource.deleteProduct(1)).called(1);
    });

    test('should return ServerFailure when remote delete throws an exception', () async {
      when(() => mockRemoteDataSource.deleteProduct(1))
          .thenThrow(Exception());

      final result = await repository.deleteProduct(1);

      expect(result, const Left(ServerFailure()));
      verify(() => mockRemoteDataSource.deleteProduct(1)).called(1);
      verifyNever(() => mockLocalDataSource.deleteProduct(1));
    });
  });
}
