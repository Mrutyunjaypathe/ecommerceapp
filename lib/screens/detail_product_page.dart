import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailProductPage extends StatelessWidget {
  final String? productId;
  final Map<String, dynamic>? extra;

  const DetailProductPage({super.key, this.productId, this.extra});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    final String productName = extra?['productName'] ?? 'TMA-2HD Wireless';
    final String productImageUrl = extra?['imageUrl'] ?? 'assets/images/headphone.jpg';
    final String productPrice = extra?['newPrice'] ?? 'Rs 1.500.000';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Detail Product',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () => debugPrint('Share tapped'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () => context.go('/detail'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.015),
            ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              child: Image.asset(
                productImageUrl,
                width: double.infinity,
                height: screenHeight * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              productName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06 / textScaleFactor,
              ),
            ),
            Text(
              productPrice,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05 / textScaleFactor,
                color: Colors.red,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.04),
                Text('4.6', style: TextStyle(fontSize: screenWidth * 0.035)),
                SizedBox(width: screenWidth * 0.01),
                Text('86 Reviews', style: TextStyle(fontSize: screenWidth * 0.035)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Reviews : 250', style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            GestureDetector(
              onTap: () => context.push('/seller_info'),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://placehold.co/100x100/CCCCCC/000000?text=Shop'),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Shop Larson Electronic', style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: const [
                            Text('Official Store', style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 4),
                            Icon(Icons.verified, size: 16, color: Colors.blue),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Text('Description Product', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'The speaker unit contains a diaphragm that is precision–grown from NAC Audio bio–cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound–producing diaphragm to vibrate without the levels of distortion found in other speakers.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: screenHeight * 0.025),
            const Text('Review (86)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildReview('Helena Mickhel', '2 weeks ago', 4),
            _buildReview('Stephen Strange', '1 weeks ago', 3),
            _buildReview('Peter Parker', '2 months ago', 4),

            /// ✅ SEE ALL REVIEW BUTTON (Go to /review_product)
            Center(
              child: TextButton(
                onPressed: () {
                  context.go('/review_product');
                },
                child: const Text(
                  'See All Review',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Featured Product', style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => SizedBox(width: screenWidth * 0.03),
                itemBuilder: (_, index) => _buildFeaturedCard(context, screenWidth),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      debugPrint('Favorite button tapped');
                      // Implement favorite logic
                    },
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    label: const Text('Added'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show the Add to Cart bottom sheet
                      _showAddToCartBottomSheet(context, productName, productPrice, screenWidth, screenHeight, textScaleFactor);
                    },
                    child: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildReview(String name, String time, int stars) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://placehold.co/100x100/000000/FFFFFF?text=👤'),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
                  (index) => Icon(
                index < stars ? Icons.star : Icons.star_border,
                size: 16,
                color: Colors.amber,
              ),
            ),
          ),
          const Text('Love this product ,the qualtiy of wire and all is the best and...'),
        ],
      ),
      trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              'assets/images/headphone.jpg',
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TMA-2 HD Wireless', maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('Rp. 1.500.000', style: TextStyle(color: Colors.red)),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber),
                    SizedBox(width: 2),
                    Text('4.6'),
                    SizedBox(width: 4),
                    Text('(86 Reviews)', style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // New method to show the Add to Cart bottom sheet
  void _showAddToCartBottomSheet(BuildContext context, String productName, String productPrice, double screenWidth, double screenHeight, double textScaleFactor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take full height if needed
      backgroundColor: Colors.transparent, // Makes the background transparent to show border radius
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.05)), // Rounded top corners
          ),
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make column wrap its content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05 / textScaleFactor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: screenWidth * 0.06),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Quantity',
                style: TextStyle(
                  fontSize: screenWidth * 0.04 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  _buildQuantityButton(Icons.remove, () { debugPrint('Decrement quantity'); }),
                  SizedBox(width: screenWidth * 0.03),
                  Text('1', style: TextStyle(fontSize: screenWidth * 0.05 / textScaleFactor)),
                  SizedBox(width: screenWidth * 0.03),
                  _buildQuantityButton(Icons.add, () { debugPrint('Increment quantity'); }),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Variant',
                style: TextStyle(
                  fontSize: screenWidth * 0.04 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  _buildVariantButton('Black', screenWidth, textScaleFactor, true), // Selected
                  SizedBox(width: screenWidth * 0.02),
                  _buildVariantButton('White', screenWidth, textScaleFactor, false),
                  SizedBox(width: screenWidth * 0.02),
                  _buildVariantButton('Blue', screenWidth, textScaleFactor, false),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Belanja',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04 / textScaleFactor,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    productPrice, // Use the product's price
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05 / textScaleFactor,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Add to Cart button in bottom sheet tapped');
                    Navigator.pop(context); // Close bottom sheet
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added $productName to cart!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045 / textScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: Colors.black),
      ),
    );
  }

  Widget _buildVariantButton(String text, double screenWidth, double textScaleFactor, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[200],
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: isSelected ? Border.all(color: Colors.blue) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontSize: screenWidth * 0.038 / textScaleFactor,
        ),
      ),
    );
  }
}
