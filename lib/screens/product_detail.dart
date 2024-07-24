import 'package:flutter/material.dart';
import '../models/model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products product;
  final Set<int> wishlist;
  final Function(int) toggleWishlist;
  final Function(Products) addToCart; // Callback for adding to cart

  ProductDetailsScreen({
    required this.product,
    required this.wishlist,
    required this.toggleWishlist,
    required this.addToCart,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Products _product;
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _isLiked = widget.wishlist.contains(_product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _product.thumbnail != null
                      ? Image.network(_product.thumbnail!)
                      : Icon(Icons.image, size: 100),
                ),
                SizedBox(height: 16),
                Text(
                  _product.title ?? 'No Title',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${_product.price?.toStringAsFixed(2) ?? '0.00'}',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    widget.addToCart(_product); // Call the addToCart callback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to Cart')),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
            Positioned(
              right: 16.0,
              top: 16.0,
              child: IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _isLiked = !_isLiked;
                    if (_product.id != null) {
                      widget.toggleWishlist(_product.id!);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
