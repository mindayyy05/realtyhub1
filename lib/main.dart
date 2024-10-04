import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'providers/liked_properties_provider.dart'; // Import your provider
import 'welcome.dart';
import 'login.dart';
import 'signup.dart';
import 'home.dart';
import 'profile.dart';
import 'property.dart';
import 'property2.dart';
import 'property3.dart';
import 'search.dart';
import 'like.dart';
import 'sell.dart';
import 'cards.dart';
import 'rent.dart';
import 'sale.dart';
import 'apartment.dart';
import 'commercial.dart';
import 'townhouse.dart';
import 'propertyinfo.dart';
import 'success.dart';
import 'dashboardbought.dart';
import 'dashboardsold.dart';
import 'userdashboard.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LikedPropertiesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const WelcomePage(), // Start with the welcome page
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const MyHomePage(),
        //'/property': (context) => const PropertyPage(),
        '/property2': (context) => const PropertyPage2(),
        '/property3': (context) => const PropertyPage3(),
        '/search': (context) => const SearchPage(),
        '/profile': (context) => const ProfilePage(),
        '/like': (context) => const LikePage(), // Use LikedPropertiesPage if needed
        '/sell': (context) => const SellPage(),
        '/cards': (context) => const CardsPage(),
        '/rent': (context) => const RentPage(),
        '/sale': (context) => const SalePage(),
        '/apartment': (context) => const ApartmentPage(),
        '/commercial': (context) => const CommercialPage(),
        '/townhouse': (context) => const TownhousePage(),
        '/success': (context) =>  SuccessPage(),
        '/dashboardBought': (context) => const DashboardBoughtPage(),
        '/dashboardSold': (context) => const DashboardSoldPage(),
        '/userdashboard': (context) => const UserDashboardPage(),

      },
    );
  }
}
