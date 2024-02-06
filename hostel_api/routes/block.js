const express = require("express");
const router = express.Router();
const { protect } = require("../middleware/auth");

const {
  getBlocks,
  getBlock,
  createBlock,
  updateBlock,
  deleteBlock,
} = require("../controllers/block");

router.get("/getAllBlock", getBlocks);
router.get("/:id", getBlock);

router.post("/createBlock", createBlock);
router.put("/:id", protect, updateBlock);
router.delete("/:id", protect, deleteBlock);

module.exports = router;
