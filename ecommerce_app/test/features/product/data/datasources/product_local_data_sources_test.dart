import 'package:ecommerce_app/features/product/data/datasources/product_local_data_sources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences{}

void main() {
  ProductLocalDataSourcesImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourcesImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
}
