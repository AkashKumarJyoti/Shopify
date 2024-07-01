import mongoose from 'mongoose';

const couponCodeSchema = mongoose.Schema({
  couponCode: {
    type: String,
    required: true,
    unique: true
  },
  discountType: {
    type: String,
    enum: ['fixed', 'percentage'],
    required: true
  },
  discountAmount: {
    type: Number,
    required: true
  },
  minimumPurchaseAmount: {
    type: Number,
    required: true
  },
  endDate: {
    type: Date,
    required: true
  },
  status: {
    type: String,
    enum: ['active', 'inactive'],
    default: 'active'
  },
  applicableCategory: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Category'
  },
  applicableSubCategory: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'SubCategory'
  },
  applicableProduct: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Product'
  }
})

const couponCodeModel = mongoose.models.Coupon || mongoose.model('Coupon', couponCodeSchema);
export default couponCodeModel;