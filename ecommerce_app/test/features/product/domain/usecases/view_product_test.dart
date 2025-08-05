import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// ProductRepository implentted by mock
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetProductUsecase(mockProductRepository);
  });

  const product = Product(
    id: 1,
    name: 'Test Product',
    price: 10.0,
    description: 'Description',
    imageUrl: 'image.jpg',
  );
  test('Should return product from repository by id', () async {
    when(() => mockProductRepository.getProductById(1))
        .thenAnswer((_) async => const Right(product));

    final result = await usecase(1);

    expect(result, const Right(product));
    verify(() => mockProductRepository.getProductById(1));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
