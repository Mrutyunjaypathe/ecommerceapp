import 'package:ecommerce/screens/news_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';
import 'screens/detail_product_page.dart';
import 'screens/signin_page.dart';
import 'screens/detailed_news_page.dart';
import 'screens/search.dart';
import 'screens/review_product.dart';
import 'screens/seller_info.dart'; // ✅ NEW import
import 'providers/app_data_provider.dart';
import 'screens/category.dart';
import 'screens/resetpage.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomePage(), // Use MegaMallHomePage
      routes: <RouteBase>[
        GoRoute(
          path: 'product_detail/:productId',
          builder: (BuildContext context, GoRouterState state) {
            final String? productId = state.pathParameters['productId'];
            return DetailProductPage(
              productId: productId,
              extra: state.extra as Map<String, dynamic>?,
            );
          },
        ),
        GoRoute(
          path: 'news',
          builder: (BuildContext context, GoRouterState state) => const NewsPage(),
        ),
        GoRoute(
          path: 'news_detail/:newsId',
          builder: (BuildContext context, GoRouterState state) {
            final String? newsId = state.pathParameters['newsId'];
            return DetailNewsPage(newsId: newsId);
          },
        ),
        // Route for Category Gadget within the nested structure
        GoRoute(
          path: 'category/gadget',
          builder: (BuildContext context, GoRouterState state) {
            return const CategoryGadgetPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) => const HomePage(), // Use MegaMallHomePage
    ),
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) => const SignInPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (BuildContext context, GoRouterState state) => const SearchPage(), // Use SearchPage
    ),
    GoRoute(
      path: '/detail',
      builder: (BuildContext context, GoRouterState state) => const DetailProductPage(), // Use DetailScreen
    ),
    GoRoute(
      path: '/category/:name', // Generic category route, handles 'gadget' explicitly
      builder: (BuildContext context, GoRouterState state) {
        final categoryName = state.pathParameters['name'];
        if (categoryName == 'gadget') {
          return const CategoryGadgetPage(); // Redirect to specific Gadget page
        }
        return Scaffold(
          appBar: AppBar(title: Text('Category: ${categoryName ?? 'Unknown'}')),
          body: Center(child: Text('Content for ${categoryName ?? 'Unknown'} category')),
        );
      },
    ),
    GoRoute(
      path: '/review_product',
      builder: (BuildContext context, GoRouterState state) {
        return const ReviewProductPage();
      },
    ),
    GoRoute(
      path: '/seller_info', // New route for Seller Info
      builder: (BuildContext context, GoRouterState state) {
        return const InfoSellerPage();
      },
    ),
    GoRoute(
      path: '/resetpage', // New route for Reset Password
      builder: (BuildContext context, GoRouterState state) {
        return const ResetSignInScreen();
      },
    ),
  ],
  // Optional: Add an error page for unknown routes
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text('Page not found: ${state.error}')),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize push notification service


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
         // Add CounterProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp.router(
        title: 'Mega Mall',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Inter',
        ),
        routerConfig: _router,
      ),
    );
  }
}
