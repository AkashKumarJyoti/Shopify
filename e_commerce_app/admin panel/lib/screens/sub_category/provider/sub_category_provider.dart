import 'dart:developer';

import 'package:e_commerce_app/models/api_response.dart';
import 'package:e_commerce_app/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';


class SubCategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameCtrl = TextEditingController();
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;

  SubCategoryProvider(this._dataProvider);


  addSubCategory() async {
    try{
      Map<String, dynamic> subCategory = {
        'name': subCategoryNameCtrl.text,
        'categoryId': selectedCategory?.sId
      };

      final response = await service.addItem(endpointUrl: 'subCategories', itemData: subCategory);
      if(response.isOk) {
        // Now create the ApiResponse
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          _dataProvider.getAllSubCategory();
          log('Sub-category added');
        }
        else {
          // success = false
          SnackBarHelper.showErrorSnackBar('Failed to add Sub-category: ${apiResponse.message}');
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

  updateSubCategory() async {
    try {
      // We need to pass name and category.Sid
      if(subCategoryForUpdate != null) {
        Map<String, dynamic> subCategory = {
          'name': subCategoryNameCtrl.text,
          'categoryId': selectedCategory?.sId
        };

        final response = await service.updateItem(endpointUrl: 'subCategories', itemId: subCategoryForUpdate?.sId ?? '', itemData: subCategory);
        if(response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if(apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
            // After updating we must again fetch all the subCategories
            _dataProvider.getAllSubCategory();
          }
          else {
            SnackBarHelper.showErrorSnackBar('Failed to Update subcategory: ${apiResponse.message}');
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

  deleteSubCategory(SubCategory subCategory) async {
    try {
      // We just need to send the item id
      final response = await service.deleteItem(endpointUrl: 'subcategories', itemId: subCategory.sId ?? '');
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          // Need to fetch allSubCategories
          _dataProvider.getAllSubCategory();
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

  submitSubCategory() {
    if(subCategoryForUpdate != null) {
      updateSubCategory();
    }
    else {
      addSubCategory();
    }
  }

  setDataForUpdateSubCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameCtrl.text = subCategory.name ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == subCategory.categoryId?.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    subCategoryNameCtrl.clear();
    selectedCategory = null;
    subCategoryForUpdate = null;
  }

  updateUi(){
    notifyListeners();
  }
}