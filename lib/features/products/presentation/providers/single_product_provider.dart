import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

part 'single_product_provider.g.dart';

class SingleProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  SingleProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  SingleProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) {
    return SingleProductState(
      id: id ?? this.id,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

@riverpod
class SingleProduct extends _$SingleProduct {
  late ProductsRepository _productsRepository;
  @override
  SingleProductState build(String productId) {
    _productsRepository = ref.watch(productsRepositoryProvider);
    state = SingleProductState(id: productId);
    loadProduct();
    return state;
  }

  Product _newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: 'men',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: _newEmptyProduct(),
        );

        return;
      }

      final product = await _productsRepository.getProductById(state.id);
      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }
}
