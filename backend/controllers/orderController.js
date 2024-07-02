/*
  a) Get all orders.
  b) Get order by userId;
  c) Get order by orderid.
  d) Create a new order.
  e) Update a order by orderId.
  f) Delete a order by orderId.
*/


import asyncHandler from 'express-async-handler';
import Order from '../models/orderModel.js';

// Get all orders
const getAllOrders = asyncHandler(async (req, res) => {
  try {
    const orders = await Order.find()
        .populate('couponCode', 'id couponCode discountType discountAmount')
        .populate('userID', 'id name').sort({ _id: -1 });
    return res.json({ success: true, message: "Orders retrieved successfully.", data: orders });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Get order by userId.
const getOrderByUserId = asyncHandler(async (req, res) => {
  try {
    const userId = req.params.userId;
    const orders = await Order.find({ userID: userId })
        .populate('couponCode', 'id couponCode discountType discountAmount')
        .populate('userID', 'id name')
        .sort({ _id: -1 });
    return res.json({ success: true, message: "Orders retrieved successfully.", data: orders });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Get order by orderId
const getOrderById = asyncHandler(async (req, res) => {
  try {
    const orderID = req.params.id;
    const order = await Order.findById(orderID)
    .populate('couponCode', 'id couponCode discountType discountAmount')
    .populate('userID', 'id name');
    if (!order) {
        return res.status(404).json({ success: false, message: "Order not found." });
    }
    return res.json({ success: true, message: "Order retrieved successfully.", data: order });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});    
  }
});

// Create a order
const addNewOrder = asyncHandler(async (req, res) => {
  try {
    const { userID,orderStatus, items, totalPrice, shippingAddress, paymentMethod, couponCode, orderTotal, trackingUrl } = req.body;
    if (!userID || !items || !totalPrice || !shippingAddress || !paymentMethod || !orderTotal) {
      return res.status(400).json({ success: false, message: "User ID, items, totalPrice, shippingAddress, paymentMethod, and orderTotal are required." });
    }
    const order = new Order({ userID,orderStatus, items, totalPrice, shippingAddress, paymentMethod, couponCode, orderTotal, trackingUrl });
    await order.save();
    return res.json({ success: true, message: "Order created successfully.", data: null });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Update order
const updateOrderById = asyncHandler(async (req, res) => {
  try {
    const orderID = req.params.id;
    const { orderStatus, trackingUrl } = req.body;
    if (!orderStatus) {
        return res.status(400).json({ success: false, message: "Order Status required." });
    }

    const updatedOrder = await Order.findByIdAndUpdate(
        orderID,
        { orderStatus, trackingUrl },
        { new: true }
    );

    if (!updatedOrder) {
        return res.status(404).json({ success: false, message: "Order not found." });
    }

    return res.json({ success: true, message: "Order updated successfully.", data: null });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Delete order
const deleteOrderById = asyncHandler(async (req, res) => {
  try {
    const orderID = req.params.id;
    const deletedOrder = await Order.findByIdAndDelete(orderID);
    if (!deletedOrder) {
        return res.status(404).json({ success: false, message: "Order not found." });
    }
    return res.json({ success: true, message: "Order deleted successfully." });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

export {getAllOrders, getOrderByUserId, getOrderById, addNewOrder, updateOrderById, deleteOrderById};