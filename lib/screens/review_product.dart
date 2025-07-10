import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReviewProductPage extends StatelessWidget {
  const ReviewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    final List<Map<String, String>> reviews = [
      {'name': 'Yelena Belova', 'rating': '4.0', 'time': '2 Minggu yang lalu'},
      {'name': 'Stephen Strange', 'rating': '3.0', 'time': '1 Bulan yang lalu'},
      {'name': 'Peter Parker', 'rating': '4.0', 'time': '2 Bulan yang lalu'},
      {'name': 'T’chala', 'rating': '3.0', 'time': '1 Bulan yang lalu'},
      {'name': 'Tony Stark', 'rating': '5.0', 'time': '2 Bulan yang lalu'},
      {'name': 'Peter Quil', 'rating': '4.0', 'time': '1 Bulan yang lalu'},
      {'name': 'Wanda Maximof', 'rating': '5.0', 'time': '2 Bulan yang lalu'},
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home'); // fallback in case there's nothing to pop
            }
          },
        ),
        title: const Text(
          "Review Product",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mediaQuery.size.height * 0.02),

            // Image at the top
            Image.asset("assets/images/review.png", fit: BoxFit.contain),

            SizedBox(height: mediaQuery.size.height * 0.03),

            // Reviews summary
            Text(
              "86 Reviews",
              style: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.04 / textScaleFactor,
              ),
            ),

            SizedBox(height: mediaQuery.size.height * 0.02),

            // Reviews list
            ListView.builder(
              itemCount: reviews.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final r = reviews[index];
                return _buildReviewItem(
                  name: r['name']!,
                  rating: double.parse(r['rating']!),
                  time: r['time']!,
                  comment:
                  "Love this product ,the qualtiy of wire and all is the best and build quality is top notch i have been using this since 2022 but it is still working great",
                  screenWidth: screenWidth,
                  textScaleFactor: textScaleFactor,
                );
              },
            ),

            SizedBox(height: mediaQuery.size.height * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required double rating,
    required String time,
    required String comment,
    required double screenWidth,
    required double textScaleFactor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.06,
            backgroundImage:
            NetworkImage('https://placehold.co/100x100?text=${name[0]}'),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04 / textScaleFactor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: screenWidth * 0.032 / textScaleFactor,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating.floor()
                          ? Icons.star
                          : (index < rating
                          ? Icons.star_half
                          : Icons.star_border),
                      size: screenWidth * 0.04,
                      color: Colors.amber,
                    );
                  }),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: screenWidth * 0.036 / textScaleFactor,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
