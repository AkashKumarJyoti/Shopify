import 'dart:developer';
import 'package:e_commerce_app/models/api_response.dart';
import '../../../models/brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';


class BrandProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameCtrl = TextEditingController();
  SubCategory? selectedSubCategory;
  Brand? brandForUpdate;

  BrandProvider(this._dataProvider);


  addBrand() async {
    try {
      Map<String, dynamic> brand = {
        'name': brandNameCtrl.text,
        'subcategoryId': selectedSubCategory?.sId
      };
      final response = await service.addItem(endpointUrl: 'brands', itemData: brand);
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          _dataProvider.getAllBrand();
          log('Brand added');
        }
        else {
          SnackBarHelper.showErrorSnackBar('Failed to add brand: ${apiResponse.message}');
        }
      }
      else {
        SnackBarHelper.showErrorSnackBar('Error: ${response.body?['message'] ?? response.statusText}');
      }
    }
    catch(error) {
      SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
  }

  updateBrand() async {
    try {
      // We need to pass name and subcategory.Sid
      if(brandForUpdate != null) {
        Map<String, dynamic> brand = {
          'name': brandNameCtrl.text,
          'subcategoryId': selectedSubCategory?.sId
        };

        final response = await service.updateItem(endpointUrl: 'brands', itemId: brandForUpdate?.sId ?? '', itemData: brand);
        if(response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if(apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
            // After updating we must again fetch all the brand
            _dataProvider.getAllBrand();
          }
          else {
            SnackBarHelper.showErrorSnackBar('Failed to Update brand: ${apiResponse.message}');
          }
        }
        else {
          SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
        }
      }
    }
    catch(error) {
      SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
  }

  deleteBrand(Brand brand) async {
    try {
      // We just need to send the brand id
      final response = await service.deleteItem(endpointUrl: 'brands', itemId: brand.sId ?? '');
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          // Need to fetch allSubCategories
          _dataProvider.getAllBrand();
        }
      }
      else {
        SnackBarHelper.showErrorSnackBar('Error: ${response.body['message'] ?? response.statusText}');
      }
    }
    catch(error) {
      SnackBarHelper.showErrorSnackBar(error.toString());
      rethrow;
    }
  }

  submitBrand() {
    if(brandForUpdate != null) {
      updateBrand();
    }
    else {
      addBrand();
    }
  }

  //? set data for update on editing
  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameCtrl.text = brand.name ?? '';
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull((element) => element.sId == brand.subcategoryId?.sId);
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update brand
  clearFields() {
    brandNameCtrl.clear();
    selectedSubCategory = null;
    brandForUpdate = null;
  }

  updateUI(){
    notifyListeners();
  }
}
