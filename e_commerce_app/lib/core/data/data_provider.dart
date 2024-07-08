import 'package:e_commerce_app/models/api_response.dart';
import 'package:e_commerce_app/utility/snack_bar_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
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
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
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

  DataProvider() {
    getAllProduct();
    getAllCategory();
    getAllSubCategory();
    getAllBrand();
    getAllVariantType();
    getAllVariant();
    getAllPoster();
  }

  // For Categories
  Future<List<Category>> getAllCategory({ bool showSnack = false }) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');
      if(response.isOk) {
        ApiResponse<List<Category>> apiResponse = ApiResponse<List<Category>>.fromJson(
          response.body, (json) => (json as List).map((item) => Category.fromJson(item)).toList()
        );
        _allCategories = apiResponse.data ?? [];
        _filteredCategories = List.from(_allCategories);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    }
    catch(error) {
      if(showSnack) SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
    return _filteredCategories;
  }

  void filterCategories(String keyword) {
    if(keyword.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    }
    else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // For Subcategories
  Future<List<SubCategory>> getAllSubCategory({ bool showSnack = false }) async {
  try {
    Response response = await service.getItems(endpointUrl: 'subCategories');
    if(response.isOk) {
      ApiResponse<List<SubCategory>> apiResponse = ApiResponse<List<SubCategory>>.fromJson(
          response.body,
              (json) => (json as List).map((item) => SubCategory.fromJson(item)).toList()
      );
      _allSubCategories = apiResponse.data ?? [];
      _filteredSubCategories = List.from(_allSubCategories);
      notifyListeners();
      if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
    }
  }
  catch(error) {
    if(showSnack) SnackBarHelper.showErrorSnackBar(error.toString());
    rethrow;
  }
  return _filteredSubCategories;
}

  filterSubCategories(String keyword) {
    if(keyword.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    }
    else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subCategory) {
        return (subCategory.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }


  // For Brands
  Future<List<Brand>> getAllBrand({ bool showSnack = false }) async {
    try {
      Response response = await service.getItems(endpointUrl: 'brands');
      if(response.isOk) {
        ApiResponse<List<Brand>> apiResponse = ApiResponse.fromJson(
          response.body,
          (json) => (json as List).map((item) => Brand.fromJson(item)).toList()
        );
        _allBrands = apiResponse.data ?? [];
        _filteredBrands = List.from(_allBrands);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    }
    catch(error) {
      if(showSnack) SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
    return _filteredBrands;
  }

  filterBrands(String keyword) {
    if(keyword.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    }
    else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((brand) {
        return (brand.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }



  Future<List<VariantType>> getAllVariantType({bool showSnack = false}) async {
    try{
      Response response = await service.getItems(endpointUrl: 'variantTypes');
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
          response.body,
            (json) => (json as List).map((item) => VariantType.fromJson(item)).toList()
        );
        _allVariantTypes = apiResponse.data ?? [];
        _filteredVariantTypes = List.from(_allVariantTypes);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    }
    catch(error) {
      if(showSnack) SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
    return _filteredVariantTypes;
  }

  filterVariantTypes(String keyword) {
    if(keyword.isEmpty) {
      _filteredVariantTypes = List.from(_allVariantTypes);
    }
    else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredVariantTypes = _allVariantTypes.where((variantType) {
        return (variantType.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }


  Future<List<Variant>> getAllVariant({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'variants');
      if(response.isOk) {
        ApiResponse<List<Variant>> apiResponse = ApiResponse.fromJson(
            response.body,
                (json) => (json as List).map((item) => Variant.fromJson(item)).toList()
        );

        _allVariants = apiResponse.data ?? [];
        _filteredVariants = List.from(_allVariants);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    }
    catch(error) {
      print(error);
      SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
    return _filteredVariants;
  }

  void filterVariants(String keyword) {
    if(keyword.isEmpty) {
      _filteredVariants = List.from(_allVariants);
    }
    else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredVariants = _allVariants.where((variant) {
        return (variant.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }


  Future<List<Product>> getAllProduct({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'products');
      ApiResponse<List<Product>> apiResponse = ApiResponse<List<Product>>.fromJson(
        response.body,
          (json) => (json as List).map((item) => Product.fromJson(item)).toList()
      );
      _allProducts = apiResponse.data ?? [];
      _filteredProducts = List.from(_allProducts);
      notifyListeners();
      if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
    }
    catch(error) {
      print(error);
      SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
    return _filteredProducts;
  }

  void filterProducts(String keyword) {
    if(keyword.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    }
    else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredProducts = _allProducts.where((product) {
        final productNameContainsKeyword = (product.name ?? '').toLowerCase().contains(lowerKeyword);
        final categoryNameContainsKeyword = product.proCategoryId?.name?.toLowerCase().contains(lowerKeyword) ?? false;
        final subCategoryNameContainsKeyword = product.proSubCategoryId?.name?.toLowerCase().contains(lowerKeyword) ?? false;

        return productNameContainsKeyword || categoryNameContainsKeyword || subCategoryNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }



//TODO: should  complete getAllCoupons


//TODO: should complete filterCoupons


  Future<List<Poster>> getAllPoster({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'posters');
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse<List<Poster>>.fromJson(
          response.body,
            (json) => (json as List).map((item) => Poster.fromJson(item)).toList()
        );
        _allPosters = apiResponse.data ?? [];
        _filteredPosters = List.from(_allPosters);
        notifyListeners();
        if(showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    }
    catch(error) {
      print(error);
      SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
    return _filteredPosters;
  }


  filterPosters(String keyword) {
    print(keyword);
    if(keyword.isEmpty) {
      _filteredPosters = List.from(_allPosters);
    }
    else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredPosters = _allPosters.where((poster) {
        return (poster.posterName ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }


//TODO: should complete getAllNotifications


//TODO: should complete filterNotifications


//TODO: should complete getAllOrders


//TODO: should complete filterOrders




//TODO: should complete calculateOrdersWithStatus


  void filterProductByQuantity(String productQntType) {
    print(productQntType);
    if(productQntType == 'All Product') {
      _filteredProducts = List.from(_allProducts);
    }
    else if(productQntType == 'Out of Stock') {
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity == 0;
      }).toList();
    }
    else if(productQntType == 'Limited Stock') {
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity == 1;
      }).toList();
    }
    else if(productQntType == 'Other Stock') {
      _filteredProducts = _allProducts.where((product) {
        return product.quantity != null && product.quantity != 0 && product.quantity != 1;
      }).toList();
    }
    else {
      _filteredProducts = List.from(_allProducts);
    }
    notifyListeners();
  }

  int calculateProductWithQuantity({int? quantity}) {
    int totalProduct = 0;
    if(quantity == null) {
      totalProduct = _allProducts.length;
    }
    else {
      for(Product product in _allProducts) {
        if(product.quantity != null && product.quantity == quantity) {
          totalProduct += 1;
        }
      }
    }
    return totalProduct;
  }


}

















