import express from 'express';
import {getAllProducts, getProductById, addNewProduct, updateProductById, deleteProductById} from '../controllers/productController.js';

const productRouter = express.Router();

productRouter.get('/', getAllProducts);
productRouter.get('/:id', getProductById);
productRouter.post('/', addNewProduct);
productRouter.put('/:id', updateProductById);
productRouter.delete('/:id', deleteProductById);

export default productRouter;