import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:teslo_shop/features/products/domain/domain.dart';

typedef SearchProductsCallback = Future<List<Product>> Function(String query);

class SearchProductDelegate extends SearchDelegate<Product?> {
  final SearchProductsCallback searchProducts;
  List<Product> initialProducts;

  StreamController<List<Product>> productsStream = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchProductDelegate({
    required this.searchProducts,
    this.initialProducts = const [],
  }) : super(searchFieldLabel: 'Buscar producto');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = "",
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = "",
              icon: const Icon(Icons.clear),
            ),
          );
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
        stream: productsStream.stream,
        initialData: initialProducts,
        builder: (context, snapshot) {
          final products = snapshot.data as List<Product>;
          return ListView.builder(
            itemBuilder: (context, index) {
              final product = products[index];

              return _SearchItem(
                product: product,
                onProductSelected: (context, product) {
                  clearStreams();
                  close(context, product);
                },
              );
            },
            itemCount: products.length,
          );
        });
  }

  void _onQueryChanged(String query) async {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final productsRes = await searchProducts(query);

      initialProducts = productsRes;

      productsStream.add(productsRes);
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    productsStream.close();
  }
}

typedef OnProductSelected = void Function(
    BuildContext context, Product product);

class _SearchItem extends StatelessWidget {
  final Product product;
  final OnProductSelected onProductSelected;

  const _SearchItem({required this.product, required this.onProductSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: product.images.isEmpty
                ? Image.asset(
                    'assets/images/no-image.jpg',
                    width: 50,
                    fit: BoxFit.cover,
                  )
                : FadeInImage(
                    width: 50,
                    fit: BoxFit.cover,
                    placeholder:
                        const AssetImage('assets/loaders/bottle-loader.gif'),
                    image: NetworkImage(product.images.first),
                  ),
          ),
          title: Text(product.title, style: const TextStyle()),
          subtitle: Text('Price: ${product.price}\$'),
          onTap: () => onProductSelected(context, product),
        ),
        const Divider()
      ],
    );
  }
}
