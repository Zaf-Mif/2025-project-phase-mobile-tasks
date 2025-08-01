// product_repository_impl.dart

import 'package:dartz/dartz.dart';
// import '../../../../../test/features/product/data/repositories/product_repository_impl_test.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_sources.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

/// Implementation of ProductRepository which handles
/// data retrieval and persistence from both remote and local sources.
///
/// Uses [ProductRemoteDataSource] for network operations and
/// [ProductLocalDataSource] for local caching and fallback.
///
/// Uses error handling with [Either] to return failures or data.

class ProductRepositoryImpl implements ProductRepository {
  late final ProductRemoteDataSource remoteDataSource;
  late final ProductLocalDataSource localDataSource;
  late final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo ,
  });

  /// Attempts to fetch all products from the remote source.
  /// If it fails, tries to get cached products from local storage.
  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts.map((e) => e.toEntity()).toList());
      } catch (_) {
        // If remote fails, fallback to cache
        try {
          final cachedProducts = await localDataSource.getCachedProducts();
          return Right(cachedProducts.map((e) => e.toEntity()).toList());
        } catch (_) {
          return const Left(CacheFailure());
        }
      }
    } else {
      // Offline: use local data
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        return Right(cachedProducts.map((e) => e.toEntity()).toList());
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  /// Fetch a product by ID from remote source.
  /// Returns null if not found.
  @override
  Future<Either<Failure, Product?>> getProductById(int id) async {
    try {
      final model = await remoteDataSource.getProductById(id);
      return Right(model?.toEntity());
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  /// Creates a product remotely and saves it locally.
  @override
  Future<Either<Failure, void>> createProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await remoteDataSource.createProduct(model);
      await localDataSource.saveProduct(model);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  /// Updates a product remotely and locally.
  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await remoteDataSource.updateProduct(model);
      await localDataSource.updateProduct(model);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  /// Deletes a product remotely and locally.
  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      await localDataSource.deleteProduct(id);
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
