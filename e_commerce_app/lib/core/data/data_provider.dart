import '../../models/coupon.dart';
import '../../models/my_notification.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/variant_type.dart';
import '../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import '../../../models/category.dart';
import '../../models/brand.dart';
import '../../models/sub_category.dart';
import '../../models/variant.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [
    Category(
      sId: "1",
      name: "Category 1",
      image: "https://via.placeholder.com/150",
      createdAt: "2024-01-01",
      updatedAt: "2024-01-02",
    ),
    Category(
      sId: "2",
      name: "Category 2",
      image: "https://via.placeholder.com/150",
      createdAt: "2024-02-01",
      updatedAt: "2024-02-02",
    ),
    Category(
      sId: "3",
      name: "Category 3",
      image: "https://via.placeholder.com/150",
      createdAt: "2024-03-01",
      updatedAt: "2024-03-02",
    ),
  ];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  // Static data for the purpose of UI testing.
  List<SubCategory> _filteredSubCategories = [SubCategory(
    sId: "1",
    name: "SubCategory 1",
    categoryId: CategoryId(sId: "1", name: "Category 1"),
    createdAt: "2024-01-01",
    updatedAt: "2024-01-02",
  ),
    SubCategory(
      sId: "2",
      name: "SubCategory 2",
      categoryId: CategoryId(sId: "2", name: "Category 2"),
      createdAt: "2024-02-01",
      updatedAt: "2024-02-02",
    ),
    SubCategory(
      sId: "3",
      name: "SubCategory 3",
      categoryId: CategoryId(sId: "3", name: "Category 3"),
      createdAt: "2024-03-01",
      updatedAt: "2024-03-02",
    ),];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [
    Brand(
      sId: "1",
      name: "Brand 1",
      subcategoryId: SubcategoryId(
        sId: "1",
        name: "SubCategory 1",
        categoryId: "1",
        createdAt: "2024-01-01",
        updatedAt: "2024-01-02",
      ),
      createdAt: "2024-01-01",
      updatedAt: "2024-01-02",
    ),
    Brand(
      sId: "2",
      name: "Brand 2",
      subcategoryId: SubcategoryId(
        sId: "2",
        name: "SubCategory 2",
        categoryId: "2",
        createdAt: "2024-02-01",
        updatedAt: "2024-02-02",
      ),
      createdAt: "2024-02-01",
      updatedAt: "2024-02-02",
    ),
    Brand(
      sId: "3",
      name: "Brand 3",
      subcategoryId: SubcategoryId(
        sId: "3",
        name: "SubCategory 3",
        categoryId: "3",
        createdAt: "2024-03-01",
        updatedAt: "2024-03-02",
      ),
      createdAt: "2024-03-01",
      updatedAt: "2024-03-02",
    ),
  ];
  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];
  List<Variant> get variants => _filteredVariants;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  List<Coupon> _allCoupons = [];
  List<Coupon> _filteredCoupons = [];
  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  List<MyNotification> _allNotifications = [];
  List<MyNotification> _filteredNotifications = [];
  List<MyNotification> get notifications => _filteredNotifications;

  DataProvider() {}


//TODO: should complete getAllCategory


//TODO: should complete filterCategories

//TODO: should complete getAllSubCategory


//TODO: should complete filterSubCategories


//TODO: should complete getAllBrands


//TODO: should complete filterBrands


//TODO: should complete getAllVariantType


//TODO: should complete filterVariantTypes



//TODO: should complete getAllVariant


//TODO: should complete filterVariants


//TODO: should complete getAllProduct


//TODO: should complete filterProducts


//TODO: should complete getAllCoupons


//TODO: should complete filterCoupons


//TODO: should complete getAllPosters


//TODO: should complete filterPosters


//TODO: should complete getAllNotifications


//TODO: should complete filterNotifications


//TODO: should complete getAllOrders


//TODO: should complete filterOrders




//TODO: should complete calculateOrdersWithStatus


//TODO: should complete filterProductsByQuantity


//TODO: should complete calculateProductWithQuantity


}
