import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat/screens/product_detail.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'search_screen.dart';
import 'settings.dart';
import '../models/model.dart';
import '../service/product_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Products>> _productsFuture;
  final Set<int> _wishlist = {};
  final List<Products> _cart = [];
  int _currentIndex = 0;
  late String _userInitial;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService().fetchProducts();
    _getUserInitial();
  }

  Future<void> _getUserInitial() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        String displayName = user.displayName ?? 'User';
        _userInitial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
      });
    } else {
      setState(() {
        _userInitial = 'U';
      });
    }
  }

  void _toggleWishlist(int productId) {
    setState(() {
      if (_wishlist.contains(productId)) {
        _wishlist.remove(productId);
      } else {
        _wishlist.add(productId);
      }
    });
  }

  void _addToCart(Products product) {
    setState(() {
      _cart.add(product);
    });
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false; // Prevent the default back action
    }
    return true; // Allow the default back action
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _currentIndex == 0
            ? AppBar(
          title: Text('Home Screen'),
          actions: [
            CircleAvatar(
              child: Text(_userInitial),
            ),
            SizedBox(width: 16),
          ],
        )
            : null,
        body: _screens()[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Colors.pink),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return FutureBuilder<List<Products>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available'));
        } else {
          final products = snapshot.data!;

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
              final isLiked = product.id != null && _wishlist.contains(product.id!);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        product: product,
                        wishlist: _wishlist,
                        toggleWishlist: _toggleWishlist,
                        addToCart: _addToCart,
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
                            child: Text('${product.price?.toStringAsFixed(2) ?? '0.00'} USD'),
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
                            _toggleWishlist(product.id!);
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
    );
  }

  List<Widget> _screens() => [
    _buildHomeScreen(),
    WishlistScreen(wishlist: _wishlist, toggleWishlist: _toggleWishlist),
    CartScreen(cart: _cart),
    SearchScreen(productsFuture: _productsFuture),
    SettingsScreen(changeLanguage: (Locale locale) {  },),
  ];
}
