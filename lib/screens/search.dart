import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Sample data for "Terakhir Dicari" (Recently Searched)
    final List<String> recentSearches = [
      'TMA2 Wireless',
      'Cable',
      'Macbook',
    ];

    // Sample data for "Featured Product" (similar to HomePage)
    final List<Map<String, String>> featuredProducts = [
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/mouse.jpg', // Changed to local asset
        'price': 'Rs. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      // Add more featured products if needed
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
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input Field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Product Name',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: screenWidth * 0.038 / textScaleFactor),
                    suffixIcon: Icon(Icons.search, color: Colors.grey, size: screenWidth * 0.055),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  ),
                  style: TextStyle(fontSize: screenWidth * 0.04 / textScaleFactor),
                  onSubmitted: (value) {
                    debugPrint('Product search submitted: $value');
                    // Implement search logic here
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Terakhir Dicari (Recently Searched) Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                'Terakhir Dicari',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045 / textScaleFactor,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Column(
              children: recentSearches.map((searchItem) {
                return _buildRecentSearchItem(
                    searchItem, screenWidth, screenHeight, textScaleFactor);
              }).toList(),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Featured Product Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045 / textScaleFactor,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle "See All" for featured products
                      debugPrint('See All Featured Products tapped');
                      // context.push('/featured_products'); // Example navigation
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: screenWidth * 0.035 / textScaleFactor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.3, // Responsive height for horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = featuredProducts[index];
                  return _buildProductCard(
                    context,
                    product['title']!,
                    product['imageUrl']!, // This will now be 'assets/images/headphone.jpg'
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
            SizedBox(height: screenHeight * 0.02), // Add some bottom padding
          ],
        ),
      ),
    );
  }

  // Helper method to build individual recent search items
  Widget _buildRecentSearchItem(
      String text, double screenWidth, double screenHeight, double textScaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.005),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Colors.grey, size: screenWidth * 0.05),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenWidth * 0.04 / textScaleFactor,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey, size: screenWidth * 0.05),
            onPressed: () {
              debugPrint('Removed $text from recent searches');
              // Implement logic to remove item from list
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build product cards (reused from HomePage)
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
        // Changed from context.go to context.push for proper navigation stack
        context.push('/product_detail/product_${title.hashCode}', extra: {'productName': title, 'imageUrl': imageUrl, 'newPrice': price});
      },
      child: Container(
        width: screenWidth * 0.4, // Responsive width
        margin: EdgeInsets.only(right: screenWidth * 0.04), // Responsive margin
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.025), // Responsive border radius
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
              child: Image.asset(
                imageUrl,
                height: screenWidth * 0.25, // Responsive height
                width: double.infinity,
                fit: BoxFit.contain, // Changed from BoxFit.cover to BoxFit.contain
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
}
