/*
    For Brand section we have 5 operations:
    a) Get all brands
    b) Get brands by id
    c) Post a new brand
    d) Update the brand
    e) Delete the brand
 */

import Brand from "../models/brandModel.js";
import asyncHandler from 'express-async-handler';

const getAllBrands = asyncHandler(async (req, res) => {

});

const getBrandById = asyncHandler(async (req, res) => {

});

const addNewBrand = asyncHandler(async (req, res) => {

});

const updateBrand = asyncHandler(async (req, res) => {

});

const deleteBrand = asyncHandler(async (req, res) => {

});

export {getAllBrands, getBrandById, addNewBrand, updateBrand, deleteBrand};