/*
  a) Get all user.
  b) login.
  c) Get a user by ID.
  d) Create a new user.
  e) Update a user.
  f) Delete a user.
*/

import User from '../models/userModel.js';
import asyncHandler from 'express-async-handler';

const getAllUser = asyncHandler(async (req, res) => {
  try {
    const users = await User.find();
    res.json({ success: true, message: "Users retrieved successfully.", data: users });
  } catch (error) {
      res.status(500).json({ success: false, message: error.message });
  }
});

const login = asyncHandler(async(req, res) => {
  try {
    const {name, password} = req.body;
    // Check if the user exists
    const user = await User.findOne({ name });


    if (!user) {
        return res.status(401).json({ success: false, message: "Invalid name or password." });
    }
    // Check if the password is correct
    if (user.password !== password) {
        return res.status(401).json({ success: false, message: "Invalid name or password." });
    }

    // Authentication successful
    res.status(200).json({ success: true, message: "Login successful.",data: user });
} catch (error) {
    res.status(500).json({ success: false, message: error.message });
}
});

const getUserById = asyncHandler(async(req, res) => {
  try {
    const userID = req.params.id;
    const user = await User.findById(userID);
    if (!user) {
        return res.status(404).json({ success: false, message: "User not found." });
    }
    res.json({ success: true, message: "User retrieved successfully.", data: user });
  } catch (error) {
      res.status(500).json({ success: false, message: error.message });
  }
});

const createUser = asyncHandler(async(req, res) => {
  try {
    const { name, password } = req.body;
    if (!name || !password) {
        return res.status(400).json({ success: false, message: "Name, and password are required." });
    }
    const user = new User({ name, password });
    await user.save();
    res.json({ success: true, message: "User created successfully.", data: null });
  } catch (error) {
      res.status(500).json({ success: false, message: error.message });
  }
});

const updateUser = asyncHandler(async(req, res) => {
  try {
    const userID = req.params.id;
    const { name, password } = req.body;
    if (!name || !password) {
        return res.status(400).json({ success: false, message: "Name,  and password are required." });
    }

    const updatedUser = await User.findByIdAndUpdate(
        userID,
        { name, password },
        { new: true }
    );

    if (!updatedUser) {
        return res.status(404).json({ success: false, message: "User not found." });
    }

    res.json({ success: true, message: "User updated successfully.", data: updatedUser });
  } catch (error) {
      res.status(500).json({ success: false, message: error.message });
  }
});

const deleteUser = asyncHandler(async(req, res) => {
  try {
    const userID = req.params.id;
    const deletedUser = await User.findByIdAndDelete(userID);
    if (!deletedUser) {
        return res.status(404).json({ success: false, message: "User not found." });
    }
    res.json({ success: true, message: "User deleted successfully." });
  } catch (error) {
      res.status(500).json({ success: false, message: error.message });
  }
});

export {getAllUser, login, getUserById, createUser, updateUser, deleteUser};