const express = require("express");
const judgeController = require("../controllers/judgeController");
const router = express.Router();
const authCheck = require("../middlewares/authCheck");
const attachUser = require("../middlewares/attachUser");
router.post("/submit", authCheck, attachUser, (req, res) => {
  console.log("Submitting code for evaluation...");
  judgeController.submitCode(req, res);
});
router.post("/solution/:questionId", authCheck, attachUser, (req, res) => {
  console.log("Submitting solution for expected output...");
  judgeController.submitSolution(req, res);
});
module.exports = router;
