import mongoose from 'mongoose';

const variantSchema = new mongoose.Schema({
  name: {
    type: String, 
    required: [true, 'Name is required.']
  },
  variantTypeId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'VariantType',
    required: [true, 'VaraintType Id is required']
  }
}, {timestamps: true});

const variantTypeModel = mongoose.models.Variant || mongoose.model('Variant', variantSchema);

export default variantTypeModel;