import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/product/data/datasources/product_local_data_sources.dart';
import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future <void> init() async {
  //! Features - Product
  // BLoC
  sl.registerFactory(
    ProductBloc(
      allProducts: sl(),
      specific: sl(),
      create: sl(),
      update: sl(),
      delete: sl(),
      inputConverter: sl(),
    ) as FactoryFunc<Object>,
  );

  // Use Cases 
  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourcesImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter()); 
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
