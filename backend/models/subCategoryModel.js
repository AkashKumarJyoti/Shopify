import mongoose from "mongoose";

const subCategorySchema = new mongoose.Schema({
  name: {type: "String", required: [true, 'Name is required'], trim: true},
  categoryId: {
    type: mongoose.Schema.Types.ObjectId, 
    required: [true, 'Category Id is required'], 
    ref: 'Category'
  }
}, {timestamps: true});

const subCategoryModel = mongoose.models.SubCategory || mongoose.model('SubCategory', subCategorySchema);
export default subCategoryModel;