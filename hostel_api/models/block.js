const mongoose = require("mongoose");

const blockSchema = new mongoose.Schema({
  blockName: {
    type: String,
    required: [true, "Please add a block name"],
    unique: true,
    trim: true,
    maxlength: [20, "Block name can not be more than 20 characters"],
  },
});

module.exports = mongoose.model("Block", blockSchema);
