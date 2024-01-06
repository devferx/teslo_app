import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';

part 'search_product_provider.g.dart';

@riverpod
class SearchProduct extends _$SearchProduct {
  @override
  List<Product> build() {
    return [];
  }

  Future<List<Product>> searchProductsByQuery(String query) async {
    final products =
        await ref.read(productsRepositoryProvider).searchProductByTerm(query);

    state = products;
    return products;
  }
}
