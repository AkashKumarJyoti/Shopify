import express from 'express';
import {getAllCoupon, getCouponById, addNewCoupon, updateCoupon, deleteCoupon} from '../controllers/couponCodeController.js';
const couponRouter = express.Router();

couponRouter.get('/', getAllCoupon);
couponRouter.get('/:id', getCouponById);
couponRouter.post('/', addNewCoupon);
couponRouter.put('/:id', updateCoupon);
couponRouter.delete('/:id', deleteCoupon);

export default couponRouter;