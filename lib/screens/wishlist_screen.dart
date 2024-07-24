import 'package:flutter/material.dart';
import 'package:my_chat/screens/product_detail.dart';
import '../models/model.dart';
import '../service/product_service.dart';

class WishlistScreen extends StatelessWidget {
  final Set<int> wishlist;
  final Function(int) toggleWishlist;

  WishlistScreen({required this.wishlist, required this.toggleWishlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: FutureBuilder<List<Products>>(
        future: ProductService().fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            final products = snapshot.data!
                .where((product) => product.id != null && wishlist.contains(product.id!))
                .toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final isLiked = product.id != null && wishlist.contains(product.id!);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          product: product,
                          wishlist: wishlist,
                          toggleWishlist: toggleWishlist,
                          addToCart: (product) {}, // You can pass the addToCart function here
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Card(
                        elevation: 4.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: product.thumbnail != null
                                  ? Image.network(
                                product.thumbnail!,
                                fit: BoxFit.cover,
                              )
                                  : Icon(Icons.image, size: 50),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.title ?? 'No Title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('${product.price ?? 0} USD'),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 8.0,
                        top: 8.0,
                        child: IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            if (product.id != null) {
                              toggleWishlist(product.id!);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
