const express = require("express");
const router = express.Router();
const authController = require("../controllers/authController");

// Process the registration form
router.post("/register", authController.register);

// Process the login form
router.post("/login", authController.login);

// Process logout
router.get("/logout", authController.logout);

module.exports = router;
