const db = require("../config/db");
const { createDefaultCode } = require("../utils/helpers");
const fs = require("fs");
const path = require("path");
exports.addQuestion = async (req, res) => {
  try {
    const { descriptionValues, interactionValues } = req.body;

    if (!descriptionValues || !interactionValues) {
      return res
        .status(400)
        .send({ message: "Description and interaction values are required." });
    }

    const {
      description,
      functionName,
      questionTitle,
      selectedCategory,
      selectedDifficulty,
      videoUrl,
    } = descriptionValues;

    const { code, testCases } = interactionValues;

    if (
      !questionTitle ||
      !selectedCategory ||
      !selectedDifficulty ||
      !description ||
      !functionName ||
      !code ||
      !Array.isArray(testCases)
    ) {
      return res
        .status(400)
        .send({ message: "All required fields must be provided and valid." });
    }

    const predefinedCode = fs.readFileSync(
      path.join(__dirname, "../resources/predefined_code.py"),
      "utf8"
    );
    const newDefaultCode = createDefaultCode(functionName, testCases);

    const questionResult = await db.query(
      "INSERT INTO questions (title, category, difficulty, video_url, description, solution_code, default_code, method_name) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id",
      [
        questionTitle,
        selectedCategory,
        selectedDifficulty,
        videoUrl,
        description,
        code + predefinedCode,
        newDefaultCode,
        functionName,
      ]
    );

    const questionId = questionResult.rows[0].id;

    const testCasePromises = testCases.map((testCase, index) => {
      if (!testCase.name || !testCase.value) {
        throw new Error("Invalid test case data.");
      }
      return db.query(
        "INSERT INTO question_inputs (question_id, input_name, example_value, input_order) VALUES ($1, $2, $3, $4)",
        [questionId, testCase.name, testCase.value, index + 1]
      );
    });

    await Promise.all(testCasePromises);

    console.log("Question added successfully.");
    res.status(201).send({ message: "Question added successfully." });
  } catch (error) {
    console.error("Error adding new question");
    if (error.message === "Invalid test case data.") {
      res.status(400).send({ message: "Test case data is invalid." });
    } else {
      res.status(500).send({ message: "Error adding new question." });
    }
  }
};
