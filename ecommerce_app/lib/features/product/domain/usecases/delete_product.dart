import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteProduct(id);
  }
}
