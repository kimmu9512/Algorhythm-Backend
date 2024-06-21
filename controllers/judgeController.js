const axios = require("axios");
const db = require("../config/db");
exports.submitCode = async (req, res) => {
  const { language_id, source_code, inputs, question_id } = req.body;
  const { rows } = await db.query("SELECT * FROM questions WHERE id = $1", [
    question_id,
  ]);
  if (rows.length === 0) {
    return res.status(404).json({ error: "Question not found" });
  }
  const question = rows[0];
  const inputForJudge = btoa(
    JSON.stringify({
      method: question.method_name,
      args: inputs.map((input) => JSON.parse(input.value)),
    })
  );
  try {
    const response = await axios({
      method: "post",
      url: "https://judge0-ce.p.rapidapi.com/submissions",
      params: { base64_encoded: "true", wait: "true", fields: "*" },
      headers: {
        "Content-Type": "application/json",
        "X-RapidAPI-Key": process.env.JUDGE_API_KEY,
        "X-RapidAPI-Host": process.env.JUDGE_URL,
      },
      data: {
        source_code: source_code,
        language_id: language_id,
        stdin: inputForJudge,
      },
    });
    const coderesult = atob(response.data.stdout);
    const codeerror = atob(response.data.stderr);
    res.json(response.data);
  } catch (error) {
    console.error("Error sending code to Judge0:", error.message, error.stack);
    res.status(500).json({ error: "Failed to execute code." });
  }
};
exports.submitSolution = async (req, res) => {
  try {
    const { inputs } = req.body;

    const questionId = req.params.questionId;
    const { rows } = await db.query("SELECT * FROM questions WHERE id = $1", [
      questionId,
    ]);
    if (rows.length === 0) {
      return res.status(404).json({ error: "Question not found" });
    }
    const question = rows[0];
    const inputForJudge = btoa(
      JSON.stringify({
        method: question.method_name,
        args: inputs.map((input) => JSON.parse(input.value)),
      })
    );
    const encodedSolution = btoa(question.solution_code);
    const response = await axios({
      method: "post",
      url: "https://judge0-ce.p.rapidapi.com/submissions",
      params: { base64_encoded: "true", wait: "true", fields: "*" },
      headers: {
        "Content-Type": "application/json",
        "X-RapidAPI-Key": process.env.JUDGE_API_KEY,
        "X-RapidAPI-Host": process.env.JUDGE_URL,
      },
      data: {
        source_code: encodedSolution,
        language_id: 92,
        stdin: inputForJudge,
      },
    });
    const coderesult = atob(response.data.stdout);
    const codeerror = atob(response.data.stderr);
    res.json(response.data);
  } catch (error) {
    console.error("Error sending code to Judge0:", error.message, error.stack);
    res.status(500).json({ error: "Failed to execute code." });
  }
};
