/*
    For Brand section we have 5 operations:
    a) Get all brands
    b) Get brands by id
    c) Post a new brand
    d) Update the brand
    e) Delete the brand
 */

import Brand from "../models/brandModel.js";
import Product from "../models/productModel.js";
import asyncHandler from 'express-async-handler';

const getAllBrands = asyncHandler(async (req, res) => {
  try {
    const brands = await Brand.find().populate('subcategoryId').sort({'subcategoryId': 1});
    return res.json({success: true, message: "Brands Recieved Successfully.", data: brands});
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

const getBrandById = asyncHandler(async (req, res) => {
  try {
    const brandID = req.params.id;
    const brand = await Brand.findById(brandID).populate('subcategoryId');
    if (!brand) {
      return res.status(404).json({ success: false, message: "Brand not found." });
    }
    return res.json({success: true, message: "Brand Retrieved Successfully.", data: brand});
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

const addNewBrand = asyncHandler(async (req, res) => {
  try {
    const {name, subcategoryId} = req.body;
    if(!name || !subcategoryId) {
      return res.status(400).json({success: false, message: "Name and Subcategory ID are required field."});
    }
    const brands = new Brand({name, subcategoryId});
    await brands.save();
    return res.json({success: true, message: "Brand created successfully", data: null});
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

const updateBrand = asyncHandler(async (req, res) => {
  try {
    const brandID = req.params.id;
    const {name, subcategoryId} = req.body;
    if(!name || !subcategoryId) {
      return res.status(400).json({success: false, message: "Name and Subcategory ID are required field."});
    }
    const brand = await Brand.findByIdAndUpdate(brandID, {name, subcategoryId}, {new: true});

    if(!brand) {
      return res.status(404).json({success: false, message: "Brand not found."});
    }
    return res.json({success: true, message: "Brand updated successfully.", data: null});
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

const deleteBrand = asyncHandler(async (req, res) => {
  try {
    // Check if any products reference this brand
    const brandID = req.params.id;
    const products = await Product.find({ proBrandId: brandID });
    if (products.length > 0) {
        return res.status(400).json({ success: false, message: "Cannot delete brand. Products are referencing it." });
    }
    const brand = await Brand.findByIdAndDelete(brandID);

    if(!brand) {
      return res.status(404).json({success: false, message: "Brand not found."});
    }

    return res.json({success: true, message: "Brand deleted successfully."});
    
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

export {getAllBrands, getBrandById, addNewBrand, updateBrand, deleteBrand};