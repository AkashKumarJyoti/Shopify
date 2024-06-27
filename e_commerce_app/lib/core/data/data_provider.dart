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
  List<VariantType> _filteredVariantTypes = [VariantType(
    name: "Color",
    type: "String",
    sId: "1",
    createdAt: "2022-01-01T00:00:00Z",
    updatedAt: "2022-01-01T00:00:00Z",
  ),
    VariantType(
      name: "Size",
      type: "String",
      sId: "2",
      createdAt: "2022-02-01T00:00:00Z",
      updatedAt: "2022-02-01T00:00:00Z",
    ),
    VariantType(
      name: "Weight",
      type: "Number",
      sId: "3",
      createdAt: "2022-03-01T00:00:00Z",
      updatedAt: "2022-03-01T00:00:00Z",
    ),
    VariantType(
      name: "Material",
      type: "String",
      sId: "4",
      createdAt: "2022-04-01T00:00:00Z",
      updatedAt: "2022-04-01T00:00:00Z",
    ),
    VariantType(
      name: "Length",
      type: "Number",
      sId: "5",
      createdAt: "2022-05-01T00:00:00Z",
      updatedAt: "2022-05-01T00:00:00Z",
    ),];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [Variant(
    sId: "1",
    name: "Red",
    variantTypeId: VariantTypeId(
      sId: "1",
      name: "Color",
      type: "String",
      createdAt: "2022-01-01T00:00:00Z",
      updatedAt: "2022-01-01T00:00:00Z",
    ),
    createdAt: "2022-01-01T00:00:00Z",
    updatedAt: "2022-01-01T00:00:00Z",
  ),
    Variant(
      sId: "2",
      name: "Medium",
      variantTypeId: VariantTypeId(
        sId: "2",
        name: "Size",
        type: "String",
        createdAt: "2022-02-01T00:00:00Z",
        updatedAt: "2022-02-01T00:00:00Z",
      ),
      createdAt: "2022-02-01T00:00:00Z",
      updatedAt: "2022-02-01T00:00:00Z",
    ),
    Variant(
      sId: "3",
      name: "500g",
      variantTypeId: VariantTypeId(
        sId: "3",
        name: "Weight",
        type: "Number",
        createdAt: "2022-03-01T00:00:00Z",
        updatedAt: "2022-03-01T00:00:00Z",
      ),
      createdAt: "2022-03-01T00:00:00Z",
      updatedAt: "2022-03-01T00:00:00Z",
    ),
    Variant(
      sId: "4",
      name: "Cotton",
      variantTypeId: VariantTypeId(
        sId: "4",
        name: "Material",
        type: "String",
        createdAt: "2022-04-01T00:00:00Z",
        updatedAt: "2022-04-01T00:00:00Z",
      ),
      createdAt: "2022-04-01T00:00:00Z",
      updatedAt: "2022-04-01T00:00:00Z",
    ),
    Variant(
      sId: "5",
      name: "100cm",
      variantTypeId: VariantTypeId(
        sId: "5",
        name: "Length",
        type: "Number",
        createdAt: "2022-05-01T00:00:00Z",
        updatedAt: "2022-05-01T00:00:00Z",
      ),
      createdAt: "2022-05-01T00:00:00Z",
      updatedAt: "2022-05-01T00:00:00Z",
    ),];
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
  List<Order> _filteredOrders = [Order(
    shippingAddress: ShippingAddress(
      phone: "123-456-7890",
      street: "123 Main Street",
      city: "Springfield",
      state: "IL",
      postalCode: "62701",
      country: "USA",
    ),
    orderTotal: OrderTotal(
      subtotal: 100.0,
      discount: 10.0,
      total: 90.0,
    ),
    sId: "1",
    userID: UserID(
      sId: "user1",
      name: "John Doe",
    ),
    orderStatus: "Processing",
    items: [
      Items(
        productID: "product1",
        productName: "Product 1",
        quantity: 2,
        price: 45.0,
        variant: "Variant 1",
        sId: "item1",
      ),
      Items(
        productID: "product2",
        productName: "Product 2",
        quantity: 1,
        price: 55.0,
        variant: "Variant 2",
        sId: "item2",
      ),
    ],
    totalPrice: 90.0,
    paymentMethod: "Credit Card",
    couponCode: CouponCode(
      sId: "coupon1",
      couponCode: "SAVE10",
      discountType: "Percentage",
      discountAmount: 10,
    ),
    trackingUrl: "http://tracking.example.com/12345",
    orderDate: "2023-06-01T00:00:00Z",
    iV: 0,
  ),
    Order(
      shippingAddress: ShippingAddress(
        phone: "987-654-3210",
        street: "456 Elm Street",
        city: "Shelbyville",
        state: "IL",
        postalCode: "62702",
        country: "USA",
      ),
      orderTotal: OrderTotal(
        subtotal: 200.0,
        discount: 20.0,
        total: 180.0,
      ),
      sId: "2",
      userID: UserID(
        sId: "user2",
        name: "Jane Smith",
      ),
      orderStatus: "Shipped",
      items: [
        Items(
          productID: "product3",
          productName: "Product 3",
          quantity: 3,
          price: 60.0,
          variant: "Variant 3",
          sId: "item3",
        ),
        Items(
          productID: "product4",
          productName: "Product 4",
          quantity: 1,
          price: 80.0,
          variant: "Variant 4",
          sId: "item4",
        ),
      ],
      totalPrice: 180.0,
      paymentMethod: "PayPal",
      couponCode: CouponCode(
        sId: "coupon2",
        couponCode: "SAVE20",
        discountType: "Amount",
        discountAmount: 20,
      ),
      trackingUrl: "http://tracking.example.com/67890",
      orderDate: "2023-06-05T00:00:00Z",
      iV: 0,
    ),
    Order(
      shippingAddress: ShippingAddress(
        phone: "555-555-5555",
        street: "789 Oak Street",
        city: "Capital City",
        state: "IL",
        postalCode: "62703",
        country: "USA",
      ),
      orderTotal: OrderTotal(
        subtotal: 150.0,
        discount: 15.0,
        total: 135.0,
      ),
      sId: "3",
      userID: UserID(
        sId: "user3",
        name: "Alice Johnson",
      ),
      orderStatus: "Delivered",
      items: [
        Items(
          productID: "product5",
          productName: "Product 5",
          quantity: 5,
          price: 30.0,
          variant: "Variant 5",
          sId: "item5",
        ),
      ],
      totalPrice: 135.0,
      paymentMethod: "Credit Card",
      couponCode: CouponCode(
        sId: "coupon3",
        couponCode: "SAVE15",
        discountType: "Amount",
        discountAmount: 15,
      ),
      trackingUrl: "http://tracking.example.com/54321",
      orderDate: "2023-06-10T00:00:00Z",
      iV: 0,
    ),];
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
