/*
  a) Get all variantTypes.
  b) Get all variantTypesById.
  c) Create a variantType.
  d) Update a variantType.
  e) Delete a variantType.
*/

import VariantType from '../models/variantTypeModel.js';
import Product from '../models/productModel.js';
import asyncHandler from 'express-async-handler';

// Get all variantTypes
const getAllVariantType = asyncHandler(async (req, res) => {
  try {
    const variantTypes = await VariantType.find();
    return res.json({success: true, message: 'VariantTypes retrieved successfully.', data: variantTypes});
  } catch (error) {
    return res.json({success: false, message: error.message});
  }
});

// Get variantType by Id
const getvariantTypeById = asyncHandler(async (req, res) => {
  try {
    const variantTypeID = req.params.id;
    const variantType = await VariantType.findById(variantTypeID);
    if(!variantType) {
      return res.status(404).json({success: false, message: 'Variant Type not found.'})
    }
    return res.json({success: true, message: 'Variant Type retrieved successfully.', data: variantType});
  } catch (error) {
    return res.json({success: false, message: error.message});
  }
});

// Create a new VariantType
const addNewVariantType = asyncHandler(async (req, res) => {
  try {
    const {name, type} = req.body;
    if (!name) {
      return res.status(400).json({ success: false, message: "Name is required." });
    }
    const variantType = new VariantType({ name , type });
    await variantType.save();
    res.json({ success: true, message: "VariantType created successfully.", data: null });
  } catch (error) {
    return res.json({success: false, message: error.message});
  }
}); 

// Update VariantTypeById
const updateVariantType = asyncHandler(async (req, res) => {
  try {
    const variantTypeID = req.params.id;
    const { name ,type } = req.body;
    if (!name) {
        return res.status(400).json({ success: false, message: "Name is required." });
    }

    const updatedVariantType = await VariantType.findByIdAndUpdate(variantTypeID, { name , type}, { new: true });
    if (!updatedVariantType) {
        return res.status(404).json({ success: false, message: "VariantType not found." });
    }
    res.json({ success: true, message: "VariantType updated successfully.", data: null });
  } catch (error) {
    return res.json({success: false, message: error.message});
  }
});

// Delete VariantTypeById
const deleteVariantType = asyncHandler(async (req, res) => {
  try {
    const variantTypeID = req.params.id;
    // Check if any variant is associated with this variant type
    const variantCount = await VariantType.countDocuments({ variantTypeId: variantTypeID });
    if (variantCount > 0) {
        return res.status(400).json({ success: false, message: "Cannot delete variant type. It is associated with one or more variants." });
    }
    
    // Check if any products reference this variant type
    const products = await Product.find({ proVariantTypeId: variantTypeID });
    if (products.length > 0) {
        return res.status(400).json({ success: false, message: "Cannot delete variant type. Products are referencing it." });
    }

    // If no variants or products are associated, proceed with deletion of the variant type
    const variantType = await VariantType.findByIdAndDelete(variantTypeID);
    console.log(variantType);
    if (!variantType) {
        return res.status(404).json({ success: false, message: "Variant type not found." });
    }
    res.json({ success: true, message: "Variant type deleted successfully." });
  } catch (error) {
    console.log(error);
    return res.json({success: false, message: error.message});
  }
});

export {getAllVariantType, getvariantTypeById, addNewVariantType, updateVariantType, deleteVariantType};