import 'package:flutter/material.dart';
import '../models/model.dart';
import 'product_detail.dart'; // Import the ProductDetailsScreen

class SearchScreen extends StatefulWidget {
  final Future<List<Products>> productsFuture;

  SearchScreen({required this.productsFuture});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Products> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_search);
  }

  void _search() {
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      widget.productsFuture.then((products) {
        setState(() {
          _searchResults = products
              .where((product) =>
          product.title != null && product.title!.toLowerCase().startsWith(query))
              .toList();
        });
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(child: Text('No results found'))
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return ListTile(
                  leading: product.thumbnail != null
                      ? Image.network(product.thumbnail!)
                      : Icon(Icons.image, size: 50),
                  title: Text(product.title ?? 'No Title'),
                  subtitle: Text('${product.price ?? 0} USD'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          product: product,
                          wishlist: {}, // Pass wishlist as needed
                          toggleWishlist: (id) {}, // Pass toggleWishlist function as needed
                          addToCart: (product) {}, // Pass addToCart function as needed
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
