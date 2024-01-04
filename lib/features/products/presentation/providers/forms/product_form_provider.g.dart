// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productFormHash() => r'b566647944b21f1cc0e6626b7721f9d02f85391c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductForm
    extends BuildlessAutoDisposeNotifier<ProductFormState> {
  late final Product product;
  late final void Function(Map<String, dynamic>) onSubmitCallback;

  ProductFormState build({
    required Product product,
    required void Function(Map<String, dynamic>) onSubmitCallback,
  });
}

/// See also [ProductForm].
@ProviderFor(ProductForm)
const productFormProvider = ProductFormFamily();

/// See also [ProductForm].
class ProductFormFamily extends Family<ProductFormState> {
  /// See also [ProductForm].
  const ProductFormFamily();

  /// See also [ProductForm].
  ProductFormProvider call({
    required Product product,
    required void Function(Map<String, dynamic>) onSubmitCallback,
  }) {
    return ProductFormProvider(
      product: product,
      onSubmitCallback: onSubmitCallback,
    );
  }

  @override
  ProductFormProvider getProviderOverride(
    covariant ProductFormProvider provider,
  ) {
    return call(
      product: provider.product,
      onSubmitCallback: provider.onSubmitCallback,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productFormProvider';
}

/// See also [ProductForm].
class ProductFormProvider
    extends AutoDisposeNotifierProviderImpl<ProductForm, ProductFormState> {
  /// See also [ProductForm].
  ProductFormProvider({
    required Product product,
    required void Function(Map<String, dynamic>) onSubmitCallback,
  }) : this._internal(
          () => ProductForm()
            ..product = product
            ..onSubmitCallback = onSubmitCallback,
          from: productFormProvider,
          name: r'productFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productFormHash,
          dependencies: ProductFormFamily._dependencies,
          allTransitiveDependencies:
              ProductFormFamily._allTransitiveDependencies,
          product: product,
          onSubmitCallback: onSubmitCallback,
        );

  ProductFormProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
    required this.onSubmitCallback,
  }) : super.internal();

  final Product product;
  final void Function(Map<String, dynamic>) onSubmitCallback;

  @override
  ProductFormState runNotifierBuild(
    covariant ProductForm notifier,
  ) {
    return notifier.build(
      product: product,
      onSubmitCallback: onSubmitCallback,
    );
  }

  @override
  Override overrideWith(ProductForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductFormProvider._internal(
        () => create()
          ..product = product
          ..onSubmitCallback = onSubmitCallback,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
        onSubmitCallback: onSubmitCallback,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ProductForm, ProductFormState>
      createElement() {
    return _ProductFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductFormProvider &&
        other.product == product &&
        other.onSubmitCallback == onSubmitCallback;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);
    hash = _SystemHash.combine(hash, onSubmitCallback.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductFormRef on AutoDisposeNotifierProviderRef<ProductFormState> {
  /// The parameter `product` of this provider.
  Product get product;

  /// The parameter `onSubmitCallback` of this provider.
  void Function(Map<String, dynamic>) get onSubmitCallback;
}

class _ProductFormProviderElement
    extends AutoDisposeNotifierProviderElement<ProductForm, ProductFormState>
    with ProductFormRef {
  _ProductFormProviderElement(super.provider);

  @override
  Product get product => (origin as ProductFormProvider).product;
  @override
  void Function(Map<String, dynamic>) get onSubmitCallback =>
      (origin as ProductFormProvider).onSubmitCallback;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
