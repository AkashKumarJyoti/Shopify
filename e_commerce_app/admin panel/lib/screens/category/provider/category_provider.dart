import 'dart:developer';
import 'dart:io';
import 'package:e_commerce_app/models/api_response.dart';
import 'package:e_commerce_app/utility/snack_bar_helper.dart';
import 'package:intl/date_symbols.dart';
import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addCategoryFormKey = GlobalKey<FormState>();
  TextEditingController categoryNameCtrl = TextEditingController();
  Category? categoryForUpdate;


  File? selectedImage;
  XFile? imgXFile;


  CategoryProvider(this._dataProvider);

  addCategory() async {
    try {
      if(selectedImage == null) {
        SnackBarHelper.showErrorSnackBar('Please Choose A Image !');
        return ;
      }
      Map<String, dynamic> formDataMap = {
        'name': categoryNameCtrl.text,
        'image': 'no_data'    // Image path will be added from server side
      };

      final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);

      final response = await service.addItem(endpointUrl: 'categories', itemData: form);
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true) {
          _dataProvider.getAllCategory();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('category added');
        }
        else {
          SnackBarHelper.showErrorSnackBar('Failed to add category: ${apiResponse.message}');
        }
      }
      else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch(error) {
      print(error);
      SnackBarHelper.showErrorSnackBar('An error occurred: $error');
      rethrow;
    }
  }

  updateCategory() async {
    // We pass the previous image url but if new image is uploaded then it will be changed from the server end.
    // But if we don't add the new image i.e., the image url will remain as it is.
    try {
      Map<String, dynamic> formDataMap = {
        'name': categoryNameCtrl.text,
        'image': categoryForUpdate?.image ?? ''
      };
      final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);

      // Now make the api call
      final response = await service.updateItem(endpointUrl: 'categories', itemId: categoryForUpdate?.sId ?? '', itemData: form);
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Category Updated');
          _dataProvider.getAllCategory();
        }
        else {
          SnackBarHelper.showErrorSnackBar('Failed to update category: ${apiResponse.message}');
        }
      }
      else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      }
    }
    catch(error) {
      print(error);
      SnackBarHelper.showErrorSnackBar('An error occurred: $error');
      rethrow;
    }
  }

  deleteCategory(Category category) async {
    try {
      // We don't need to send any data we will just send the id of the item which needs to be deleted from the database
      final response = await service.deleteItem(endpointUrl: 'categories', itemId: category.sId ?? '');
      if(response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Category Deleted');
          _dataProvider.getAllCategory();
        }
        else {
          SnackBarHelper.showErrorSnackBar('Failed to delete category: ${apiResponse.message}');
        }
      }
      else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      }
    }
    catch(error) {
      print(error);
      rethrow;
    }
  }

  submitCategory() {
    if(categoryForUpdate != null) {
      updateCategory();
    }
    else {
      addCategory();
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      imgXFile = image;
      notifyListeners();
    }
  }




  //? to create form data for sending image with body
  Future<FormData> createFormData({required XFile? imgXFile, required Map<String, dynamic> formData}) async {
    if (imgXFile != null) {
      MultipartFile multipartFile;
      if (kIsWeb) {
        String fileName = imgXFile.name;
        Uint8List byteImg = await imgXFile.readAsBytes();
        multipartFile = MultipartFile(byteImg, filename: fileName);
      } else {
        String fileName = imgXFile.path.split('/').last;
        multipartFile = MultipartFile(imgXFile.path, filename: fileName);
      }
      formData['img'] = multipartFile;
    }
    final FormData form = FormData(formData);
    return form;
  }

  //? set data for update on editing
  setDataForUpdateCategory(Category? category) {
    if (category != null) {
      clearFields();
      categoryForUpdate = category;
      categoryNameCtrl.text = category.name ?? '';
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    categoryNameCtrl.clear();
    selectedImage = null;
    imgXFile = null;
    categoryForUpdate = null;
  }
}
