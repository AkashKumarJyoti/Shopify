import express from 'express';
import {getAllVariantType, getvariantTypeById, addNewVariantType, updateVariantType, deleteVariantType} from '../controllers/variantTypeController.js';

const variantTypeRouter = express.Router();

variantTypeRouter.get('/', getAllVariantType);
variantTypeRouter.get('/:id', getvariantTypeById);
variantTypeRouter.post('/', addNewVariantType);
variantTypeRouter.put('/:id', updateVariantType);
variantTypeRouter.delete('/:id', deleteVariantType);

export default variantTypeRouter;