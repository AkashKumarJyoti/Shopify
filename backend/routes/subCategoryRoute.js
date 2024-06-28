import express from 'express';
import {getAllSubCategories, getSubCategoriesById, addNewSubCategory, updateSubCategory, deleteSubCategory} from '../controllers/subCategoryConroller.js';
import { getAllCategories } from '../controllers/categoryController';
const subCategoryRouter = express.Router();

subCategoryRouter.get('/', getAllCategories);
subCategoryRouter.get('/:id', getSubCategoriesById);
subCategoryRouter.post('/', addNewSubCategory);
subCategoryRouter.put('/:id', updateSubCategory);
subCategoryRouter.delete('/:id', deleteSubCategory);

export default subCategoryRouter;