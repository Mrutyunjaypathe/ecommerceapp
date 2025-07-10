// lib/screens/detail_news_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailNewsPage extends StatelessWidget {
  // You can pass arguments like news ID or data if needed
  final String? newsId;

  const DetailNewsPage({super.key, this.newsId});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Sample data for the news article (replace with actual data fetching)
    const String mainImageUrl = 'assets/images/newscar.png'; // Changed to local asset
    const String newsTitle = 'Philosophy Tips for Caring for Your Car Body to Prevent It from Looking Dull';
    const String newsDate = '13 Jan 2021';
    const String newsContent = '''
The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.
''';

    // Sample data for "Other News" section
    final List<Map<String, String>> otherNews = [
      {
        'title': 'Philosophy That Addresses Topics Such As Goodness',
        'description': 'Agar tetap kinclong, bodi motor ten...',
        'date': '13 Jan 2021',
        'imageUrl': 'assets/images/news.png', // Changed to local asset
      },
      {
        'title': 'Many Inquiries Outside Of Academia Are Philosophical In The Broad Sense',
        'description': 'In one general sense, philosophy is ass...',
        'date': '13 Jan 2021',
        'imageUrl': 'assets/images/news.png', // Changed to local asset
      },
      // You can add more news items here
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
          'Detail News',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black), // Share icon
            onPressed: () {
              // Handle share action
              debugPrint('Share tapped');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main News Image
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                child: Image.asset( // Changed to Image.asset
                  mainImageUrl,
                  width: double.infinity,
                  height: screenHeight * 0.25, // Responsive height
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: screenHeight * 0.25,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, color: Colors.grey[600], size: screenWidth * 0.1),
                    );
                  },
                ),
              ),
            ),
            // News Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01), // Increased horizontal padding
              child: Text(
                newsTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.055 / textScaleFactor,
                  color: Colors.black,
                ),
              ),
            ),
            // News Date
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Increased horizontal padding
              child: Text(
                newsDate,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: screenWidth * 0.035 / textScaleFactor,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // News Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Increased horizontal padding
              child: Text(
                newsContent,
                style: TextStyle(
                  fontSize: screenWidth * 0.038 / textScaleFactor,
                  height: 1.5, // Line height for readability
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Other News Section Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Increased horizontal padding
              child: Text(
                'Other News',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045 / textScaleFactor,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            // Other News List
            ...otherNews.map((news) => _buildOtherNewsItem(
              context,
              news['title']!,
              news['description']!,
              news['date']!,
              news['imageUrl']!,
              screenWidth,
              screenHeight,
              textScaleFactor,
            )).toList(),

            SizedBox(height: screenHeight * 0.02),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle view all news
                  context.pop(); // Example: Go back to the main News page
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
    );
  }

  // Helper method to build individual "Other News" list items
  Widget _buildOtherNewsItem(
      BuildContext context,
      String title,
      String description,
      String date,
      String imageUrl,
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01), // Increased horizontal padding
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04 / textScaleFactor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: screenWidth * 0.035 / textScaleFactor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: screenWidth * 0.03 / textScaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                child: Image.asset( // Changed from Image.network to Image.asset
                  imageUrl, // This will now be 'assets/images/news.png'
                  width: screenWidth * 0.25, // Square image as in the reference
                  height: screenWidth * 0.25, // Square image as in the reference
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, color: Colors.grey[600]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}