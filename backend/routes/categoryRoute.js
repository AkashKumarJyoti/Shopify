import express from 'express';
import {getAllCategories, getCategoryById, addNewCategory, updateCategory, deleteCategory} from '../controllers/categoryController.js';

const categoryRouter = express.Router();

categoryRouter.get('/', getAllCategories);
categoryRouter.get('/:id', getCategoryById);
categoryRouter.post('/', addNewCategory);
categoryRouter.put('/:id', updateCategory);
categoryRouter.delete('/:id', deleteCategory)

export default categoryRouter;