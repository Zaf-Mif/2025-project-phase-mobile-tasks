import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_sources.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Attempts to fetch all products from remote source if online.
  /// Falls back to local cached data if offline or remote call fails.
  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        // Cache products locally after successful remote fetch
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts.map((e) => e.toEntity()).toList());
      } catch (_) {
        // On remote failure, try to return cached products
        try {
          final cachedProducts = await localDataSource.getCachedProducts();
          return Right(cachedProducts.map((e) => e.toEntity()).toList());
        } catch (_) {
          return const Left(CacheFailure());
        }
      }
    } else {
      // Offline: return cached products or failure if none cached
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        return Right(cachedProducts.map((e) => e.toEntity()).toList());
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  /// Fetches a product by ID only if device is online.
  /// Returns [ServerFailure] if offline or remote call fails.
  @override
  Future<Either<Failure, Product?>> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getProductById(id);
        return Right(model?.toEntity());
      } catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      // No network connection available
      return const Left(ServerFailure());
    }
  }

  /// Creates a product remotely and saves it locally if online.
  /// Returns [ServerFailure] if offline or remote call fails.
  @override
  Future<Either<Failure, void>> createProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel.fromEntity(product);
        await remoteDataSource.createProduct(model);
        await localDataSource.saveProduct(model);
        return const Right(null);
      } catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      // No network connection available
      return const Left(ServerFailure());
    }
  }

  /// Updates a product remotely and locally if online.
  /// Returns [ServerFailure] if offline or remote call fails.
  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel.fromEntity(product);
        await remoteDataSource.updateProduct(model);
        await localDataSource.updateProduct(model);
        return const Right(null);
      } catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      // No network connection available
      return const Left(ServerFailure());
    }
  }

  /// Deletes a product remotely and locally if online.
  /// Returns [ServerFailure] if offline or remote call fails.
  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        await localDataSource.deleteProduct(id);
        return const Right(null);
      } catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      // No network connection available
      return const Left(ServerFailure());
    }
  }
}
