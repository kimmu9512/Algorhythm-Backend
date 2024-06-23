const express = require("express");
const router = express.Router();
const authController = require("../controllers/authController");

// Process the registration form
router.post("/register", authController.register);

module.exports = router;
