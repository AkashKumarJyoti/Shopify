/*
    For SubCategory section we have 5 operations:
    a) Get all subCategories
    b) Get subCategory by id
    c) Create a new subCategory
    d) Update the subCategory by id
    e) Delete the subCategory by id
 */

import asyncHandler from 'express-async-handler';
import SubCategory from '../models/subCategoryModel.js';
import Brand from '../models/brandModel.js';
import Product from '../models/productModel.js';

// Get all subcategories
const getAllSubCategories = asyncHandler(async (req, res) => {
  try{
    const subCategories = await SubCategory.find({}).populate('categoryId').sort({'categoryId': 1});
    return res.json({ success: true, message: "Sub-categories retrieved successfully.", data: subCategories });
  }
  catch(error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get subCategory by id
const getSubCategoriesById = asyncHandler(async (req, res) => {
  try {
    const subCategoryID = req.params.id;
    const subCategory = await SubCategory.findById(subCategoryID).populate('categoryId');
    if(!subCategory) {
      return res.status(404).json({ success: false, messagge: "SubCategory Not Found."});
    }
    return res.json({success: true, message: "SubCategory retrieved successfully.", data: subCategory});
  } catch (error) {
      res.status(500).json({success: false, message: error.message});
  }
});

// Create a new SubCategory
const addNewSubCategory = asyncHandler(async (req, res) => {
  try {
    const {name, categoryId} = req.body;
    if(!name || !categoryId) {
      return res.status(400).json({success: false, message: "Name and category ID are required"})
    }
    const subCategory = SubCategory({name, categoryId});
    await subCategory.save();

    return res.json({success: true, message: "Sub-category created successfully.", data: null});
  } catch (error) {
    return res.status(500).json({success: false, message: error.messagge});
  }
});

// Update the subCategory by id
const updateSubCategory = asyncHandler(async (req, res) => {
  try {
    const subCategoryID = req.params.id;
    const {name, categoryId} = req.body;

    if(!name || !categoryId) {
      res.status(400).json({success: false, message: "Name and Sub-category are required"});
    }
    const updatedSubCategory = await SubCategory.findByIdAndUpdate(subCategoryID, {name, categoryId}, {new : true});
    console.log(updatedSubCategory);
    if(!updatedSubCategory) {
      return res.status(404).json({success: false, message: "Sub-category not found"});
    }
    return res.json({success: true, message: "Sub-category updated successfully.", data: null});
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Delete the subCategory by id
const deleteSubCategory = asyncHandler(async (req, res) => {
  // Brand and Product depend on SubCategory. So, before deleting we need to check whether any prodcut or brand exists corresponding to that subCategory.
  try{
    const subCategoryID = req.params.id;

    //TODO: Check for Brand and Product
    const brandCount = await Brand.countDocuments({ subcategoryId: subCategoryID });
    if (brandCount > 0) {
        return res.status(400).json({ success: false, message: "Cannot delete sub-category. It is associated with one or more brands." });
    }

    const products = await Product.find({ proSubCategoryId: subCategoryID });
    if (products.length > 0) {
        return res.status(400).json({ success: false, message: "Cannot delete sub-category. Products are referencing it." });
    }

    const subCategory = await SubCategory.findByIdAndDelete(subCategoryID);
    if(!subCategory) {
      return res.status(404).json({success: false, message: "Sub-category not found"});
    }
    return res.json({success: true, message: "Sub-category deletd successfully"})
  } catch(error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

export {getAllSubCategories, getSubCategoriesById, addNewSubCategory, updateSubCategory, deleteSubCategory};