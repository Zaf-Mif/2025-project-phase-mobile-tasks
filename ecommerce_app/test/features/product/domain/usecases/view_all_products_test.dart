import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// ProductRepository implentted by mock
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ViewAllProductsUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = ViewAllProductsUsecase(mockProductRepository);
  });

  final products = [
    const Product(id: 1, name: 'Test Product', price: 9.99, description: 'Test product desciption', imageUrl: 'images.jpg'),
  ];
  test('Should return list of products from repositories', () async {
    when( () =>
      mockProductRepository.getAllProducts(),
    ).thenAnswer((_) async => Right(products));

    final result = await usecase();

    expect(result, Right(products));
    verify(() => mockProductRepository.getAllProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
