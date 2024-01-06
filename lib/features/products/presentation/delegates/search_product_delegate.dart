import 'dart:async';

import 'package:flutter/material.dart';

import 'package:teslo_shop/features/products/domain/domain.dart';

typedef SearchProductsCallback = Future<List<Product>> Function(String query);

class SearchProductDelegate extends SearchDelegate<Product?> {
  final SearchProductsCallback searchProducts;
  List<Product> initialProducts;

  StreamController<List<Product>> productsStream = StreamController.broadcast();

  SearchProductDelegate({
    required this.searchProducts,
    this.initialProducts = const [],
  }) : super(searchFieldLabel: 'Buscar producto');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
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
    final products = initialProducts;

    return StreamBuilder(
        stream: productsStream.stream,
        initialData: initialProducts,
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final product = products[index];

              return _SearchItem(
                product: product,
                onProductSelected: (context, product) {
                  close(context, product);
                },
              );
            },
            itemCount: products.length,
          );
        });
  }

  void _onQueryChanged(String query) async {
    final productsRes = await searchProducts(query);
    initialProducts = productsRes;
    productsStream.add(productsRes);
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
            child: FadeInImage(
              width: 50,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
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
