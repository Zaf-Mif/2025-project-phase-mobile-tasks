import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// ProductRepository implentted by mock
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late CreateProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  final newProduct = Product(
    id: 3,
    name: 'New Product',
    price: 15.0,
    description: 'New desc',
    imageUrl: 'new.jpg',
  );

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = CreateProductUsecase(mockProductRepository);
    registerFallbackValue(newProduct);
  });

  test('Should create new product through repository', () async {
    when(() => mockProductRepository.createProduct(newProduct))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(newProduct);

    expect(result, const Right(null));
    verify(() => mockProductRepository.createProduct(newProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
