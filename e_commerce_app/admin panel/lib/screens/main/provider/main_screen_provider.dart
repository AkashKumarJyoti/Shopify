import '../../brands/brand_screen.dart';
import '../../category/category_screen.dart';
import '../../coupon_code/coupon_code_screen.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../notification/notification_screen.dart';
import '../../order/order_screen.dart';
import '../../posters/poster_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../sub_category/sub_category_screen.dart';
import '../../variant/variant_screen.dart';
import '../../variant_type/variant_type_screen.dart';

class MainScreenProvider extends ChangeNotifier{
  Widget selectedScreen = const DashboardScreen();



  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        selectedScreen = const DashboardScreen();
        break; // Break statement needed here
      case 'Category':
        selectedScreen = const CategoryScreen();
        break;
      case 'SubCategory':
        selectedScreen = SubCategoryScreen();
        break;
      case 'Brands':
        selectedScreen = BrandScreen();
        break;
      case 'VariantType':
        selectedScreen = VariantsTypeScreen();
        break;
      case 'Variants':
        selectedScreen = VariantsScreen();
        break;
      case 'Coupon':
        selectedScreen = CouponCodeScreen();
        break;
      case 'Poster':
        selectedScreen = PosterScreen();
        break;
      case 'Order':
        selectedScreen = OrderScreen();
        break;
      case 'Notifications':
        selectedScreen = NotificationScreen();
        break;
      default:
        selectedScreen = DashboardScreen();
    }
    notifyListeners();
  }
  
  
}