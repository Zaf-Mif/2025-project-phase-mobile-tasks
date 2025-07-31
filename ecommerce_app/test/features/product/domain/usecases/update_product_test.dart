import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// ProductRepository implentted by mock
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late UpdateProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = UpdateProductUsecase(mockProductRepository);
  });

  const updatedProduct = Product(
    id: 1,
    name: 'Updated Product',
    price: 20.0,
    description: 'Updated',
    imageUrl: 'updated.jpg',
  );

  test('Should update product in repository', () async {
    when(() => mockProductRepository.updateProduct(updatedProduct))
        .thenAnswer((_) async =>const Right(null));

    final result = await usecase(updatedProduct);

    expect(result,const  Right(null));
    verify(() => mockProductRepository.updateProduct(updatedProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
