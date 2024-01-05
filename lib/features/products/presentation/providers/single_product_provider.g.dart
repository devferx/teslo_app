// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$singleProductHash() => r'94d85236fc090e59d67d90d96a3514c8d811df4c';

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

abstract class _$SingleProduct
    extends BuildlessAutoDisposeNotifier<SingleProductState> {
  late final String productId;

  SingleProductState build(
    String productId,
  );
}

/// See also [SingleProduct].
@ProviderFor(SingleProduct)
const singleProductProvider = SingleProductFamily();

/// See also [SingleProduct].
class SingleProductFamily extends Family<SingleProductState> {
  /// See also [SingleProduct].
  const SingleProductFamily();

  /// See also [SingleProduct].
  SingleProductProvider call(
    String productId,
  ) {
    return SingleProductProvider(
      productId,
    );
  }

  @override
  SingleProductProvider getProviderOverride(
    covariant SingleProductProvider provider,
  ) {
    return call(
      provider.productId,
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
  String? get name => r'singleProductProvider';
}

/// See also [SingleProduct].
class SingleProductProvider
    extends AutoDisposeNotifierProviderImpl<SingleProduct, SingleProductState> {
  /// See also [SingleProduct].
  SingleProductProvider(
    String productId,
  ) : this._internal(
          () => SingleProduct()..productId = productId,
          from: singleProductProvider,
          name: r'singleProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$singleProductHash,
          dependencies: SingleProductFamily._dependencies,
          allTransitiveDependencies:
              SingleProductFamily._allTransitiveDependencies,
          productId: productId,
        );

  SingleProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  SingleProductState runNotifierBuild(
    covariant SingleProduct notifier,
  ) {
    return notifier.build(
      productId,
    );
  }

  @override
  Override overrideWith(SingleProduct Function() create) {
    return ProviderOverride(
      origin: this,
      override: SingleProductProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SingleProduct, SingleProductState>
      createElement() {
    return _SingleProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleProductProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SingleProductRef on AutoDisposeNotifierProviderRef<SingleProductState> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _SingleProductProviderElement extends AutoDisposeNotifierProviderElement<
    SingleProduct, SingleProductState> with SingleProductRef {
  _SingleProductProviderElement(super.provider);

  @override
  String get productId => (origin as SingleProductProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
