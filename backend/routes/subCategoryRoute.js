import express from 'express';
import {getAllSubCategories, getSubCategoriesById, addNewSubCategory, updateSubCategory, deleteSubCategory} from '../controllers/subCategoryConroller.js';
const subCategoryRouter = express.Router();

subCategoryRouter.get('/', getAllSubCategories);
subCategoryRouter.get('/:id', getSubCategoriesById);
subCategoryRouter.post('/', addNewSubCategory);
subCategoryRouter.put('/:id', updateSubCategory);
subCategoryRouter.delete('/:id', deleteSubCategory);

export default subCategoryRouter;