import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/app_data_provider.dart'; // Import your provider

class HomePage extends StatefulWidget { // Changed to StatefulWidget
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // State variable for the selected bottom navigation item

  @override
  Widget build(BuildContext context) {
    // Access MediaQuery data for responsive sizing
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0); // Get default text scale

    // Access your AppDataProvider using Provider
    final appDataProvider = Provider.of<AppDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Example of using provider to change a state
            appDataProvider.toggleSidebar();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sidebar status: ${appDataProvider.isSidebarOpen ? "Open" : "Closed"}')));
          },
        ),
        title: Text(
          'Mega Mall',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05, // Responsive font size
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Handle search tap - Navigate to the SearchPage using push
              context.push('/search'); // <--- Changed from context.go to context.push
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Handle cart tap
              context.go('/detail'); // Navigate to detail screen (simulated cart)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView prevents overflow if content exceeds screen height
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: GestureDetector( // <--- Added GestureDetector here
                onTap: () {
                  // Navigate to the SearchPage when the search bar is tapped using push
                  context.push('/search'); // <--- Changed from context.go to context.push
                },
                child: AbsorbPointer( // <--- Added AbsorbPointer to make TextField non-editable on tap
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search here...',
                      hintStyle: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor),
                      prefixIcon: Icon(Icons.search, color: Colors.grey, size: screenWidth * 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide.none, // No border line
                      ),
                      filled: true,
                      fillColor: Colors.grey[200], // Light grey background
                      contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.015), // Responsive padding
                    ),
                    style: TextStyle(fontSize: screenWidth * 0.04 / textScaleFactor),
                    onSubmitted: (value) {
                      // This will still work if the user types and presses enter,
                      // but the primary interaction is now the tap to navigate.
                      debugPrint('Search submitted from HomePage search bar: $value');
                    },
                  ),
                ),
              ),
            ),

            // Top Banner Section
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
              child: Container(
                height: screenHeight * 0.2, // Responsive height
                decoration: BoxDecoration(
                  color: Colors.redAccent, // This color will only be visible if the image doesn't load
                  borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
                  // Set banner.png as the background image
                  image: const DecorationImage(
                    image: AssetImage('assets/images/banner.png'), // Your new banner image
                    fit: BoxFit.cover, // This makes the image cover the entire container
                    alignment: Alignment.center, // Center the image within the box
                  ),
                ),
                child: const Stack(
                  children: [
                    // The image is now the background, so no need for a Positioned Image.asset here
                    // Removed the CircleAvatar as requested
                  ],
                ),
              ),
            ),

            // Categories Section (Using Wrap for better responsiveness if items overflow horizontally)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: screenWidth * 0.02, // Horizontal spacing between items
                runSpacing: screenHeight * 0.01, // Vertical spacing between rows
                children: [
                  _buildCategoryItem(Icons.flash_on, 'Flash Sale', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.card_giftcard, 'Voucher', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.local_shipping, 'Delivery', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.devices, 'Gadget', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.more_horiz, 'More', screenWidth, screenHeight, textScaleFactor),
                ],
              ),
            ),

            // Featured Products Section
            _buildSectionHeader('Featured Product', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3, // Responsive height for horizontal list
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/mouse.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Mid Banner Section
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Container(
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  color: Colors.green, // This color will only be visible if the image doesn't load
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  // Set greenbanner.png as the background image
                  image: const DecorationImage(
                    image: AssetImage('assets/images/greenbanner.png'), // Your new green banner image
                    fit: BoxFit.cover, // This makes the image cover the entire container
                    alignment: Alignment.center, // Center the image within the box
                  ),
                ),
                // Removed the Center widget containing the Text
              ),
            ),

            // Best Sellers Section
            _buildSectionHeader('Best Sellers', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/mouse.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset (assuming drill is also now headphones)
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Modular Headphones Banner - UPDATED TO USE bluebanner.png
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Container(
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blueAccent, // This color will only be visible if the image doesn't load
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bluebanner.png'), // Your new blue banner image
                    fit: BoxFit.cover, // This makes the image cover the entire container
                    alignment: Alignment.center, // Center the image within the box
                  ),
                ),
                child: const Stack( // Keep Stack if you might add overlay elements later, otherwise can be removed
                  children: [
                    // Removed the Positioned Text and Icon as the image now covers the area
                  ],
                ),
              ),
            ),

            // New Arrivals Section (Still using product cards as per your code structure)
            _buildSectionHeader('New Arrivals', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/mouse.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Top Rated Products Section
            _buildSectionHeader('Top Rated Product', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/mouse.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Special Offers Section
            _buildSectionHeader('Special Offers', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset (assuming drill is also now headphones)
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/mouse.jpg', // Changed to local asset
                    'Rs 1.000.000',
                    'Rs 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Latest News Section
            _buildSectionHeader('Latest News', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                children: [
                  _buildNewsCard(
                    'How to apply the right makeup for your skin tone',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'assets/images/news.png', // Changed to local asset
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildNewsCard(
                    'Best furniture for your new home',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'assets/images/news.png', // Changed to local asset
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildNewsCard(
                    'Top 5 places to visit in Bali for your next vacation',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'assets/images/news.png', // Changed to local asset
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle view all news - Navigate to the main News listing page
                  context.go('/news');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                ),
                child: Text(
                  'See All News',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04 / textScaleFactor),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Use the state variable
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Ensures all labels are shown
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
          debugPrint('BottomNavigationBar tapped at index: $index'); // Debug print
          switch (index) {
            case 0: // Home
              context.go('/'); // Navigate to the root (HomePage)
              break;
            case 1: // Wishlist
            // context.go('/wishlist'); // You might need to define this route
              break;
            case 2: // My Order
            // context.go('/my_order'); // You might need to define this route
              break;
            case 3: // Profile
              debugPrint('Profile icon tapped. Showing login dialog.');
              _showLoginRequiredDialog(context, screenWidth, screenHeight, textScaleFactor); // Show the dialog
              break;
          }
        },
      ),
    );
  }

  // Helper method to build category items
  Widget _buildCategoryItem(IconData icon, String label, double screenWidth, double screenHeight, double textScaleFactor) {
    return Column(
      children: [
        Container( // Wrap CircleAvatar in a Container for shadow
          decoration: BoxDecoration(
            color: Colors.white, // White background as seen in the image
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Subtle shadow
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2), // Position of shadow
              ),
            ],
          ),
          child: CircleAvatar(
            radius: screenWidth * 0.06, // Responsive radius
            backgroundColor: Colors.transparent, // Make CircleAvatar transparent to show Container's color/shadow
            child: Icon(icon, color: Colors.black87, size: screenWidth * 0.06), // Softer black for icon
          ),
        ),
        SizedBox(height: screenHeight * 0.008), // Spacing between icon and text
        Text(
          label,
          style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.black), // Responsive font size
        ),
      ],
    );
  }

  // Helper method to build section headers
  Widget _buildSectionHeader(String title, String actionText, double screenWidth, double textScaleFactor, BuildContext context, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: screenWidth * 0.045 / textScaleFactor, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              // Example of navigation using go_router
              context.go('/category'); // Example: navigate to a category page
            },
            child: Text(
              actionText,
              style: TextStyle(color: Colors.blue, fontSize: screenWidth * 0.035 / textScaleFactor),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build product cards
  Widget _buildProductCard(
      BuildContext context, // Added BuildContext for navigation
      String title,
      String imageUrl, // This imageUrl will now be 'assets/images/headphone.jpg'
      String oldPrice,
      String newPrice,
      String discount,
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return GestureDetector(
      onTap: () {
        // Example of go_router navigation to a product detail page
        context.go('/product_detail/product_${title.hashCode}', extra: {'productName': title, 'imageUrl': imageUrl, 'newPrice': newPrice});
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
              child: Image.asset( // Changed from Image.network to Image.asset
                imageUrl, // This will now be 'assets/images/headphone.jpg'
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
                    oldPrice,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: screenWidth * 0.03 / textScaleFactor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        newPrice,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035 / textScaleFactor),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015, vertical: screenHeight * 0.003),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                        ),
                        child: Text(
                          '$discount Off',
                          style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.025 / textScaleFactor),
                        ),
                      ),
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

  // Helper method to build news cards
  Widget _buildNewsCard(
      String title, String description, String imageUrl, double screenWidth, double screenHeight, double textScaleFactor) {
    return GestureDetector( // Added GestureDetector for tap functionality
      onTap: () {
        // Navigate to the NewsPage when a news card is tapped
        context.go('/news'); // Navigate to the main News listing page
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              child: Image.asset( // Changed from Image.network to Image.asset
                imageUrl, // This will now be 'assets/images/news.png'
                width: screenWidth * 0.25, // Responsive width
                height: screenWidth * 0.2, // Responsive height
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
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.038 / textScaleFactor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.03 / textScaleFactor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // New helper method to show the login required dialog
  void _showLoginRequiredDialog(BuildContext context, double screenWidth, double screenHeight, double textScaleFactor) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            width: screenWidth * 0.8, // Responsive width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey, size: screenWidth * 0.06), // Responsive icon size
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close the dialog
                    },
                  ),
                ),
                Text(
                  'Login Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055 / textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '👋', // Waving hand emoji
                  style: TextStyle(fontSize: screenWidth * 0.15), // Large emoji size
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'You need to sign in first.',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045 / textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Please login/register first \nto make a transaction',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035 / textScaleFactor,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06, // Responsive button height
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close the dialog first
                      context.go('/signin'); // Navigate to the sign-in page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                    ),
                    child: Text(
                      'Login',
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
          ),
        );
      },
    );
  }
}
