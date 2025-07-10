// lib/screens/category_gadget_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryGadgetPage extends StatelessWidget {
  const CategoryGadgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Sample data for products in the "Gadget" category
    final List<Map<String, String>> gadgetProducts = [
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Using local asset for consistency
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Using local asset for consistency
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Using local asset for consistency
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Using local asset for consistency
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Using local asset for consistency
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Using local asset for consistency
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      // Add more products as needed
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
          'Category',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              debugPrint('Cart tapped');
              context.go('/detail'); // Navigate to a generic detail screen or cart
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
            child: Text(
              'Gadget',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.07 / textScaleFactor,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Product Name',
                  hintStyle: TextStyle(fontSize: screenWidth * 0.04 / textScaleFactor),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: screenWidth * 0.05),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                onChanged: (value) {
                  debugPrint('Search query: $value');
                  // Implement search logic here
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: screenWidth * 0.03, // Spacing between columns
                  mainAxisSpacing: screenHeight * 0.02, // Spacing between rows
                  childAspectRatio: 0.7, // Adjust as needed to fit content
                ),
                itemCount: gadgetProducts.length,
                itemBuilder: (context, index) {
                  final product = gadgetProducts[index];
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
          ),
          // Filter & Sorting Button at the bottom
          _buildFilterSortingButton(context, screenWidth, screenHeight, textScaleFactor),
        ],
      ),
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
              child: Image.asset( // Using Image.asset for local image
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

  // Helper method for the Filter & Sorting Button
  Widget _buildFilterSortingButton(BuildContext context, double screenWidth, double screenHeight, double textScaleFactor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
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
      child: ElevatedButton(
        onPressed: () {
          debugPrint('Filter & Sorting tapped');
          // Implement filter and sorting logic/navigation
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
          ),
        ),
        child: Text(
          'Filter & Sorting',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045 / textScaleFactor,
          ),
        ),
      ),
    );
  }
}
