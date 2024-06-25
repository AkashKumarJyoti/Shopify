import 'package:e_commerce_app/core/data/data_provider.dart';
import 'package:e_commerce_app/core/routes/app_pages.dart';
import 'package:e_commerce_app/screens/brands/provider/brand_provider.dart';
import 'package:e_commerce_app/screens/category/provider/category_provider.dart';
import 'package:e_commerce_app/screens/coupon_code/provider/coupon_code_provider.dart';
import 'package:e_commerce_app/screens/dashboard/provider/dashboard_provider.dart';
import 'package:e_commerce_app/screens/main/main_screen.dart';
import 'package:e_commerce_app/screens/main/provider/main_screen_provider.dart';
import 'package:e_commerce_app/screens/notification/provider/notification_provider.dart';
import 'package:e_commerce_app/screens/order/provider/order_provider.dart';
import 'package:e_commerce_app/screens/posters/provider/poster_provider.dart';
import 'package:e_commerce_app/screens/sub_category/provider/sub_category_provider.dart';
import 'package:e_commerce_app/screens/variant/provider/variant_provider.dart';
import 'package:e_commerce_app/screens/variant_type/provider/variant_type_provider.dart';
import 'package:e_commerce_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => DataProvider()),
      ChangeNotifierProvider(create: (context) => MainScreenProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => SubCategoryProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => BrandProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => VariantsTypeProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => VariantsProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => DashBoardProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => CouponCodeProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => PosterProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => OrderProvider(context.read<DataProvider>())),
      ChangeNotifierProvider(create: (context) => NotificationProvider(context.read<DataProvider>())),
    ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white)
      ),
      initialRoute: AppPages.HOME,
      unknownRoute: GetPage(name: '/notFound', page: () => MainScreen()),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    );
  }
}