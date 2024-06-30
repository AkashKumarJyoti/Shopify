import mongoose from 'mongoose';

const brandSchema = new mongoose.Schema({
  name: {type: String, required: [true, "Name is required"], trim: true},
  subcategoryId: {type: mongoose.Schema.Types.ObjectId, ref: 'SubCategory' ,reqiured: [true, 'Subcategory ID is required']}
}, {timestamps: true});

const brandModel = mongoose.models.Brand || mongoose.model('Brand', brandSchema);
export default brandModel;
