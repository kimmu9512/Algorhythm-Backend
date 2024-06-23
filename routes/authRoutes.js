const express = require("express");
const router = express.Router();
const authController = require("../controllers/authController");

// Process the registration form
router.post("/register", authController.register);
// Check if user exists
router.get("/checkUser", authController.checkUser);
module.exports = router;
