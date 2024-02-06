const asyncHandler = require("../middleware/async");
const Block = require("../models/block");

// @desc    Get all blocks
// @route   GET /api/v1/blocks
// @access  Public

exports.getBlocks = async (req, res, next) => {
  try {
    const blocks = await Block.find();

    res.status(200).json({
      success: true,
      count: blocks.length,
      data: blocks,
    });
  } catch (err) {
    res.status(400).json({ success: false });
  }
};

// @desc    Get single block
// @route   GET /api/v1/blocks/:id
// @access  Public

exports.getBlock = async (req, res, next) => {
  try {
    const block = await Block.findById(req.params.id);

    if (!block) {
      return res.status(401).json({ message: "cannot find the block with " });
    }

    res.status(200).json({ success: true, data: block });
  } catch (err) {
    next(err);
  }
};

// @desc    Create new block
// @route   POST /api/v1/blocks
// @access  Private

exports.createBlock = async (req, res, next) => {
  try {
    const block = await Block.create(req.body);

    res.status(201).json({
      success: true,
      data: block,
    });
  } catch (err) {
    next(err);
  }
};

// @desc    Update block
// @route   PUT /api/v1/blocks/:id
// @access  Private

exports.updateBlock = async (req, res, next) => {
  try {
    let block = await Block.findById(req.params.id);
    if (!block) {
      return res
        .status(404)
        .json({ message: "block not found with id of ${req.params.id}" });
    }

    block = await block.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });

    res.status(200).json({ success: true, data: block });
  } catch (err) {
    next(err);
  }
};

// @desc    Delete block
// @route   DELETE /api/v1/blocks/:id
// @access  Private

exports.deleteBlock = async (req, res, next) => {
  // delete block by id
  await Block.findByIdAndDelete(req.params.id).then((block) => {
    if (!block) {
      return res
        .status(404)
        .json({ message: "Block not found with id of ${req.params.id}" });
    }
    res.status(200).json({ success: true, data: block });
  });
};
