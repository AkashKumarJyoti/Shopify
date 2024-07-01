/*
  a) Get all coupons
  b) Get coupon by id
  c) Add new coupon
  d) Update coupon
  e) Delete coupon
*/

import asyncHandler from 'express-async-handler';
import Coupon from '../models/couponCodeModel';

// Get all coupon
const getAllCoupon = asyncHandler(async (req, res) => {
  try {
    const coupons = await Coupon.find().populate('applicableCategory', 'id name').populate('applicableSubCategory', 'id name').populate('applicableProduct', 'id name');

    return res.json({success: true, message: "Coupon retrieved successfully.", data: coupons})
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Get coupon by id
const getCouponById = asyncHandler(async (req, res) => {
  try {
    const couponID = req.params.id;
    const coupon = await Coupon.findById(couponID).populate('applicableCategory', 'id name').populate('applicableSubCategory', 'id name').populate('applicableProduct', 'id name');
    
    if(!coupon) {
      return res.status(404).json({success: false, message: 'Coupon not found.'});
    }
    return res.json({success: true, message: 'Coupon Retrieved successfully.', data: coupon});
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Add new coupon
const addNewCoupon = asyncHandler(async (req, res) => {
  try {
    const { couponCode, discountType, discountAmount, minimumPurchaseAmount, endDate, status, applicableCategory, applicableSubCategory, applicableProduct } = req.body;
    if (!couponCode || !discountType || !discountAmount || !endDate || !status) {
        return res.status(400).json({ success: false, message: "Code, discountType, discountAmount, endDate, and status are required." });
    }

    const coupon = new Coupon({
      couponCode,
      discountType,
      discountAmount,
      minimumPurchaseAmount,
      endDate,
      status,
      applicableCategory,
      applicableSubCategory,
      applicableProduct
    });

    await coupon.save();
    return res.json({success: true, message: 'Coupon created successfully.', data: null});
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Update coupon
const updateCoupon = asyncHandler(async (req, res) => {
  try {
    const couponID = req.params.id;
    const { couponCode, discountType, discountAmount, minimumPurchaseAmount, endDate, status, applicableCategory, applicableSubCategory, applicableProduct } = req.body;
    console.log(req.body)
    if (!couponCode || !discountType || !discountAmount || !endDate || !status) {
        return res.status(400).json({ success: false, message: "CouponCode, discountType, discountAmount, endDate, and status are required." });
    }

    const updatedCoupon = await Coupon.findByIdAndUpdate(
        couponID,
        { couponCode, discountType, discountAmount, minimumPurchaseAmount, endDate, status, applicableCategory, applicableSubCategory, applicableProduct },
        { new: true }
    );

    if (!updatedCoupon) {
        return res.status(404).json({ success: false, message: "Coupon not found." });
    }

    return res.json({ success: true, message: "Coupon updated successfully.", data: null });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Delete coupon
const deleteCoupon = asyncHandler(async (req, res) => {
  try {
    const couponID = req.params.id;
    const deletedCoupon = await Coupon.findByIdAndDelete(couponID);
    if (!deletedCoupon) {
        return res.status(404).json({ success: false, message: "Coupon not found." });
    }
    return res.json({ success: true, message: "Coupon deleted successfully." });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

export {getAllCoupon, getCouponById, addNewCoupon, updateCoupon, deleteCoupon};