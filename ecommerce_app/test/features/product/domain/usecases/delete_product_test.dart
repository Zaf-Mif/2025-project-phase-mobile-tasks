import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// ProductRepository implentted by mock
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late DeleteProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = DeleteProductUsecase(mockProductRepository);
  });

  const productId = 1;

  test('Should delete product by id using repository', () async {
    when(() => mockProductRepository.deleteProduct(productId))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(productId);

    expect(result, const Right(null));
    verify(() => mockProductRepository.deleteProduct(productId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
