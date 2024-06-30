import express from 'express';
import {getAllBrands, getBrandById, addNewBrand, updateBrand, deleteBrand} from '../controllers/brandController.js';

const brandRouter = express.Router();

brandRouter.get('/', getAllBrands);
brandRouter.get('/:id', getBrandById);
brandRouter.post('/', addNewBrand);
brandRouter.put('/:id', updateBrand);;
brandRouter.delete('/:id', deleteBrand);

export default brandRouter;