import 'package:dio/dio.dart';

import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/errors/product_errors.dart';

import '../mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDataSource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({
    required this.accessToken,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiURl,
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        );

  Future<String> _uploadFile(String path) async {
    try {
      final fileName = path.split('/').last;

      final FormData data = FormData.fromMap(
          {'file': MultipartFile.fromFileSync(path, filename: fileName)});

      final response = await dio.post('/files/product', data: data);

      return response.data['image'];
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<String>> _uploadPhotos(List<String> photos) async {
    final photosToUpload =
        photos.where((photo) => photo.contains('/')).toList();
    final photosToIgnore =
        photos.where((photo) => !photo.contains('/')).toList();

    final List<Future<String>> uploadJob =
        photosToUpload.map(_uploadFile).toList();

    final newImages = await Future.wait(uploadJob);

    return [...photosToIgnore, ...newImages];
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? productId = productLike['id'];
      final String method = productId == null ? 'POST' : 'PATCH';
      final String url =
          (productId == null) ? '/products' : '/products/$productId';

      productLike.remove('id');
      productLike['images'] = await _uploadPhotos(productLike['images']);

      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method,
        ),
      );

      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/products',
        queryParameters: {'limit': limit, 'offset': offset});

    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) async {
    if (term.isEmpty) return [];

    try {
      final response = await dio.get('/products/all/$term');
      final List<Product> products = [];

      for (final product in response.data ?? []) {
        products.add(ProductMapper.jsonToEntity(product));
      }

      return products;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) return [];

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
