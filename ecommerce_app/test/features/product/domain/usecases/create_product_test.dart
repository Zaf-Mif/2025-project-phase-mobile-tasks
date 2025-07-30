import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

/// ProductRepository implentted by mock
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late CreateProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = CreateProductUsecase(mockProductRepository);

  });
}
