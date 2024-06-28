/*
    For Category section we have 5 operations:
    a) Get all categories
    b) Get category by id
    c) Post a new category
    d) Update the category
    e) Delete the category
 */

import asyncHandler from 'express-async-handler';
import Category from "../models/categoryModel.js";
import {uploadCategory} from '../uploadFile.js';
import multer from 'multer';
import fs from 'fs';
import path from 'path';

const getAllCategories = asyncHandler(async (req, res) => {
    try {
        const categories = await Category.find({});
        res.json({ success: true, message: "Categories retrieved successfully.", data: categories });
    }
    catch(error) {
        console.log(error);
        res.status(500).json({ success: false, message: error.message });
    }
});

const getCategoryById = asyncHandler(async (req, res) => {
    try {
        const categoryID = req.params.id;
        const category = await Category.findById(categoryID);

        if (!category) {
            return res.status(404).json({ success: false, message: "Category not found." });
        }
        console.log(category);
        res.json({ success: true, message: "Category retrieved successfully.", data: category });
    }
    catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

const addNewCategory = asyncHandler(async (req, res) => {
    try {
        uploadCategory.single('img')(req, res, async function (err) {
            if (err instanceof multer.MulterError) {
                if (err.code === 'LIMIT_FILE_SIZE') {
                    err.message = 'File size is too large. Maximum filesize is 5MB.';
                }
                console.log(`Add category: ${err}`);
                return res.json({ success: false, message: err });
            } else if (err) {
                console.log(`Add category: ${err}`);
                return res.json({ success: false, message: err });
            }
            const { name } = req.body;
            let imageUrl = 'no_url';
            if (req.file) {
                imageUrl = `http://localhost:3000/image/category/${req.file.filename}`;
            }
            console.log('url ', req.file)

            if (!name) {
                return res.status(400).json({ success: false, message: "Name is required." });
            }

            try {
                const newCategory = new Category({
                    name: name,
                    image: imageUrl
                });
                await newCategory.save();
                res.json({ success: true, message: "Category created successfully.", data: null });
            } catch (error) {
                console.error("Error creating category:", error);
                res.status(500).json({ success: false, message: error.message });
            }

        });

    } catch (err) {
        console.log(`Error creating category: ${err.message}`);
        return res.status(500).json({ success: false, message: err.message });
    }
});

const updateCategory = asyncHandler(async (req, res) => {
    try {
        const categoryID = req.params.id;
        const oldCategory = await Category.findById(categoryID);

        if (!oldCategory) {
            return res.status(404).json({ success: false, message: "Category not found." });
        }

        uploadCategory.single('img')(req, res, async function (err) {
            if (err instanceof multer.MulterError) {
                if (err.code === 'LIMIT_FILE_SIZE') {
                    err.message = 'File size is too large. Maximum filesize is 5MB.';
                }
                console.log(`Update category: ${err.message}`);
                return res.json({ success: false, message: err.message });
            } else if (err) {
                console.log(`Update category: ${err.message}`);
                return res.json({ success: false, message: err.message });
            }

            const { name } = req.body;
            let image = oldCategory.image;

            if (!name || !image) {
                return res.status(400).json({ success: false, message: "Name and image are required." });
            }

            if (req.file) {
                // Delete the old image if a new one is uploaded
                if (fs.existsSync(path.join('./public/category', path.basename(oldCategory.image)))) {
                    fs.unlinkSync(path.join('./public/category', path.basename(oldCategory.image)));
                }
                image = `http://localhost:3000/image/category/${req.file.filename}`;
            }


            try {
                const updatedCategory = await Category.findByIdAndUpdate(categoryID, { name: name, image: image }, { new: true });
                if (!updatedCategory) {
                    return res.status(404).json({ success: false, message: "Category not found." });
                }
                res.json({ success: true, message: "Category updated successfully.", data: null });
            } catch (error) {
                res.status(500).json({ success: false, message: error.message });
            }
        });

    } catch (err) {
        console.log(`Error updating category: ${err.message}`);
        return res.status(500).json({ success: false, message: err.message });
    }
});


const deleteCategory = asyncHandler(async (req, res) => {
    try {
        const categoryID = req.params.id;

        // Check if any subcategories reference this category
        const subcategories = await SubCategory.find({ categoryId: categoryID });
        if (subcategories.length > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete category. Subcategories are referencing it." });
        }

        // Check if any products reference this category
        const products = await Product.find({ proCategoryId: categoryID });
        if (products.length > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete category. Products are referencing it." });
        }

        // If no subcategories or products are referencing the category, proceed with deletion
        const category = await Category.findByIdAndDelete(categoryID);
        if (!category) {
            return res.status(404).json({ success: false, message: "Category not found." });
        }

        // Delete the image file associated with the category
        if (fs.existsSync(path.join('./public/category', path.basename(category.image)))) {
            fs.unlinkSync(path.join('./public/category', path.basename(category.image)));
        }

        res.json({ success: true, message: "Category deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});


export {getAllCategories, getCategoryById, addNewCategory, updateCategory, deleteCategory};