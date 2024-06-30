import mongoose from 'mongoose';

const variantTypeSchema = new mongoose.Schema({
  name: {   // It is the name of variantType name like color, TV size.
    type: String, 
    trim: true,
    required: [true, 'Name is the required field.']
  },
  type: { // It is the type of variantType like Color, Size.
    type: String, 
    required: [true, 'Type is required.'], 
    trim: true
  }
}, {timestamps: true});

const variantTypeModel = mongoose.models.VariantType || mongoose.model('VariantType', variantTypeSchema);

export default variantTypeModel;