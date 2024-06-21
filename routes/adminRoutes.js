const express = require("express");
const adminController = require("../controllers/adminController");
const router = express.Router();
const authCheck = require("../middlewares/authCheck");
const attachUser = require("../middlewares/attachUser");
const adminCheck = require("../middlewares/adminCheck");
// Route to add a new question
router.post(
  "/add-question",
  authCheck,
  attachUser,
  adminCheck,
  adminController.addQuestion
);

module.exports = router;
