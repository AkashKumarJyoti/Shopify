/*
  a) Get all variants
  b) Get all variants by id
  c) Create a new variant referencing to variantType
  d) Update variant by id
  e) Delete variant by id
*/

import Variant from '../models/variantModel.js';
import Product from '../models/productModel.js';
import asyncHandler from 'express-async-handler';

const getAllVariants = asyncHandler(async (req, res) => {
  try {
    const variants = await Variant.find().populate('variantTypeId').sort({'variantTypeId': 1});

    res.json({success: true, message: "Variants retrieved successfully.", data: variants});
  } catch (error) {
    console.log(error);
    return res.status(500).json({success: false, message: error.message});
  }
});

const getVariantById = asyncHandler(async (req, res) => {
  try {
    const variantID = req.params.id;

    const variant = await Variant.findById(variantID).populate('variantTypeId');
    if(!variant) {
      return res.status(404).json({success: false, message: "Variant not found"});
    }
    return res.json({success: true, message: "Variant retrieved successfully", data: variant});
  } catch (error) {
    console.log(error);
    return res.status(500).json({success: false, message: error.message});
  }
});

const addNewVariant = asyncHandler(async (req, res) => {
  try {
    const {name, variantTypeId} = req.body;
    if(!name || !variantTypeId) {
      return res.status(400).json({success: false, messagge: "Name and VariantType ID are required."});
    }
    const variant = new Variant({name, variantTypeId});
    await variant.save();
    return res.json({success: true, message: "Variant created successfully.", data: null});
  } catch (error) {
    console.log(error);
    return res.status(500).json({success: false, message: error.message});
  }
});

const updateVariant = asyncHandler(async (req, res) => {
  try {
    const variantID = req.params.id;
    const {name, variantTypeId} = req.body;

    if(!name || !variantTypeId) {
      return res.status(400).json({success: false, message: "Name and Variant Type ID are required field."});
    }
    const variant = await Variant.findByIdAndUpdate(variantID, {name, variantTypeId}, {new: true});
    if(!variant) {
      return res.status(404).json({success: false, message: "Variant not found."});
    }
    return res.json({success: true, message: 'Variant updated successfully.', data: null});
  } catch (error) {
    console.log(error);
    return res.status(500).json({success: false, message: error.message});
  }
});

const deleteVariant = asyncHandler(async (req, res) => {
  try {
    const variantID = req.params.id;
    // Before deleting check whether any product is dependent or not.
    const products = await Product.find({ proVariantId: variantID });
    if (products.length > 0) {
        return res.status(400).json({ success: false, message: "Cannot delete variant. Products are referencing it." });
    }
    const variant = await Variant.findByIdAndDelete(variantID);
    if(!variant) {
      return res.status(404).json({success: false, message: 'Variant not found.'});
    }
    return res.json({success: true, message: 'Variant deleted successfully.'});
  } catch (error) {
    console.log(error);
    return res.status(500).json({success: false, message: error.message});
  }
});

export {getAllVariants, getVariantById, addNewVariant, updateVariant, deleteVariant};