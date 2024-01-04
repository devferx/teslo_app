import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:teslo_shop/features/products/domain/repositories/products_repository.dart';
import 'package:teslo_shop/features/products/infrastructure/infrastructure.dart';

import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

part 'products_repository_provider.g.dart';

@riverpod
ProductsRepository productsRepository(ProductsRepositoryRef ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';
  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken),
  );

  return productsRepository;
}
