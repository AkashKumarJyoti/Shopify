import express from 'express';
import {getAllOrders, getOrderByUserId, getOrderById, addNewOrder, updateOrderById, deleteOrderById} from '../controllers/orderController.js';

const orderRouter = express.Router();

orderRouter.get('/', getAllOrders);
orderRouter.get('/orderByUserId/:userId', getOrderByUserId);
orderRouter.get('/:id', getOrderById);
orderRouter.post('/', addNewOrder);
orderRouter.put('/:id', updateOrderById);
orderRouter.delete('/:id', deleteOrderById);

export default orderRouter;