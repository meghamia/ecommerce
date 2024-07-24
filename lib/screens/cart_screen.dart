import 'package:flutter/material.dart';
import '../models/model.dart';

class CartScreen extends StatelessWidget {
  final List<Products> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cart.isEmpty
          ? Center(child: Text('No items in cart'))
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          return ListTile(
            leading: product.thumbnail != null
                ? Image.network(product.thumbnail!)
                : Icon(Icons.image, size: 50),
            title: Text(product.title ?? 'No Title'),
            subtitle: Text('${product.price ?? 0} USD'),
          );
        },
      ),
    );
  }
}
