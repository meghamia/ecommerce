import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class ProductService {
  Future<List<Products>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/carts'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final model = Model.fromJson(jsonResponse);
      List<Products> products = [];
      model.carts?.forEach((cart) {
        if (cart.products != null) {
          products.addAll(cart.products!);
        }
      });
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
