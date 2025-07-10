// lib/screens/info_seller_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoSellerPage extends StatelessWidget {
  const InfoSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Sample data for seller's products
    final List<Map<String, String>> sellerProducts = [
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            context.pop(); // Go back to the previous screen
          },
        ),
        title: Text(
          'Info Seller',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              debugPrint('Search seller products tapped');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              debugPrint('Cart tapped');
              context.push('/detail'); // Navigate to a generic detail screen or cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seller Info Section
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.08,
                          backgroundImage: const NetworkImage('https://placehold.co/150x150/CCCCCC/000000?text=Shop'), // Placeholder for shop logo
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Shop Larson Electronic',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.045 / textScaleFactor,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  Icon(Icons.verified, color: Colors.blue, size: screenWidth * 0.04),
                                  const Spacer(),
                                  Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.04),
                                  Text(
                                    '4.6',
                                    style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Text(
                                'Official Store',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: screenWidth * 0.035 / textScaleFactor,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.grey, size: screenWidth * 0.04),
                                  SizedBox(width: screenWidth * 0.01),
                                  Text(
                                    'West Side, Near Prozone Mall (Opening Hours 08:00-21:00)',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: screenWidth * 0.035 / textScaleFactor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Seller Stats
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('followers', '23 k', screenWidth, textScaleFactor),
                        _buildStatItem('Product', '150 Item', screenWidth, textScaleFactor),
                        _buildStatItem('Join', '20 Oct 2021', screenWidth, textScaleFactor),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Dukungan Pengiriman (Shipping Support)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: GestureDetector(
                      onTap: () {
                        debugPrint('Tapped Delivery Support');
                        // Implement navigation or dialog for shipping support details
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Support',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04 / textScaleFactor,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: screenWidth * 0.04),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Products Grid
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: GridView.builder(
                      shrinkWrap: true, // Important for nested scroll views
                      physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: screenWidth * 0.03, // Spacing between columns
                        mainAxisSpacing: screenHeight * 0.02, // Spacing between rows
                        childAspectRatio: 0.7, // Adjust as needed to fit content
                      ),
                      itemCount: sellerProducts.length,
                      itemBuilder: (context, index) {
                        final product = sellerProducts[index];
                        return _buildProductCard(
                          context,
                          product['title']!,
                          product['imageUrl']!,
                          product['price']!,
                          product['rating']!,
                          product['reviews']!,
                          screenWidth,
                          screenHeight,
                          textScaleFactor,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1), // Space for bottom buttons
                ],
              ),
            ),
          ),
          // Persistent bottom bar with Sorting and Follow buttons
          _buildPersistentBottomBar(screenWidth, screenHeight, textScaleFactor),
        ],
      ),
    );
  }

  // Helper method to build seller stat items
  Widget _buildStatItem(String label, String value, double screenWidth, double textScaleFactor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045 / textScaleFactor,
            color: Colors.black,
          ),
        ),
        SizedBox(height: screenWidth * 0.005),
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035 / textScaleFactor,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // Helper method to build product cards (reused from other pages)
  Widget _buildProductCard(
      BuildContext context,
      String title,
      String imageUrl,
      String price,
      String rating,
      String reviews,
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return GestureDetector(
      onTap: () {
        // Example of go_router navigation to a product detail page
        context.go('/product_detail/product_${title.hashCode}', extra: {'productName': title, 'imageUrl': imageUrl, 'newPrice': price});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.025)),
              child: Image.asset( // Changed from Image.network to Image.asset
                imageUrl,
                height: screenWidth * 0.25, // Responsive height
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: screenWidth * 0.25,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035 / textScaleFactor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    price,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035 / textScaleFactor),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.035),
                      Text(
                        rating,
                        style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.grey[700]),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        '($reviews)',
                        style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.grey[500]),
                      ),
                      const Spacer(),
                      Icon(Icons.more_vert, color: Colors.grey, size: screenWidth * 0.05),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Persistent bottom bar with Sorting and Follow buttons
  Widget _buildPersistentBottomBar(double screenWidth, double screenHeight, double textScaleFactor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3), // Shadow at the top
          ),
        ],
      ),
      child: Row(
        children: [
          // Sorting button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Sorting button tapped');
                // Implement sorting logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blue), // Blue border
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
              ),
              child: Text(
                'Sorting',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: screenWidth * 0.04 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          // Follow button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Follow button tapped');
                // Implement follow logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue background
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
              ),
              child: Text(
                'Follow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}