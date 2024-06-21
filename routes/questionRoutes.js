const express = require("express");
const questionController = require("../controllers/questionController");
const authCheck = require("../middlewares/authCheck"); // Import authCheck middleware
const adminCheck = require("../middlewares/adminCheck");
const attachUser = require("../middlewares/attachUser");
const router = express.Router();

router.get("/random", (req, res) => {
  console.log("Fetching a random question...");
  questionController.getRandomQuestion(req, res);
});

router.get("/suggestions", authCheck, attachUser, (req, res) => {
  console.log("Fetching suggested questions...");
  questionController.getSuggestedQuestions(req, res);
});
router.get("/user-questions", authCheck, attachUser, (req, res) => {
  console.log("Fetching all questions with user history ...");
  questionController.getAllQuestionsWithUserHistory(req, res);
});
router.get("/:id", (req, res) => {
  console.log("Fetching question by ID...");
  questionController.getQuestionById(req, res);
});
router.get("/input/:id", (req, res) => {
  console.log("Fetching input for a question...");
  questionController.getQuestionInput(req, res);
});
router.post("/attempt/:questionTitle", authCheck, attachUser, (req, res) => {
  console.log("Recording an attempt for a question...");
  questionController.recordAttempt(req, res);
});

module.exports = router;
