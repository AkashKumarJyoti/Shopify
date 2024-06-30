import express from 'express';
import { addNewVariant, deleteVariant, getAllVariants, getVariantById, updateVariant } from '../controllers/variantController.js';
const variantRouter = express.Router();

variantRouter.get('/', getAllVariants);
variantRouter.get('/:id', getVariantById);
variantRouter.post('/', addNewVariant);
variantRouter.put('/:id', updateVariant);
variantRouter.delete('/:id', deleteVariant);

export default variantRouter;