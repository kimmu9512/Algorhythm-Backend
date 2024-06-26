const db = require("../config/db");
exports.getQuestionInput = async (req, res) => {
  try {
    const questionId = req.params.id;
    const { rows } = await db.query(
      "SELECT * FROM question_inputs WHERE question_id = $1 ORDER BY input_order ASC",
      [questionId]
    );
    res.status(200).json(rows);
  } catch (error) {
    console.log("Error fetching question input");
    res.status(500).json({ error: "Failed to fetch question inputs." });
  }
};
exports.getQuestionById = async (req, res) => {
  try {
    const questionId = req.params.id;

    const { rows } = await db.query("SELECT * FROM questions WHERE id = $1", [
      questionId,
    ]);

    if (rows.length > 0) {
      res.status(200).json(rows[0]);
    } else {
      res.status(404).send({ message: "Question not found." });
    }
  } catch (error) {
    console.error("Error fetching question ");
    res.status(500).send({ message: "Error fetching question by ID." });
  }
};
exports.getRandomQuestion = async (req, res) => {
  try {
    const { rows } = await db.query(
      "SELECT * FROM questions ORDER BY RANDOM() LIMIT 1"
    );
    console.log("Fetched a random question successfully.");
    res.status(200).json(rows[0]);
  } catch (error) {
    console.log("Error fetching random question");
    res.status(500).send({ message: "Error fetching random question." });
  }
};

exports.getSuggestedQuestions = async (req, res) => {
  try {
    const userId = req.user.id;

    const performanceQuery = `
    SELECT q.*, uh.prev_time, uh.attempts, COALESCE(uh.pre15_attempts, 0) AS under_15_min_count, uh.last_solved
    FROM user_question_history uh
    JOIN questions q ON q.id = uh.question_id
    WHERE uh.user_id = $1
    GROUP BY q.id, uh.user_id, uh.prev_time, uh.attempts, uh.pre15_attempts, uh.last_solved;`;

    const { rows: performanceData } = await db.query(performanceQuery, [
      userId,
    ]);
    console.log("Fetched user performance data successfully.");

    const repeatQuestions = performanceData.filter((q) => {
      let lastSolvedDate = new Date(q.last_solved);
      lastSolvedDate.setHours(0, 0, 0, 0);
      let thresholdDate = new Date(lastSolvedDate);
      if (q.under_15_min_count >= 2) {
        return false; // Exclude questions solved under 15 mins twice
      } else if (q.prev_time > 2700) {
        thresholdDate.setDate(thresholdDate.getDate() + 1); // Next day
      } else if (q.prev_time > 1800 && q.prev_time <= 2700) {
        thresholdDate.setDate(thresholdDate.getDate() + 3); // In 3 days
      } else if (q.prev_time > 900 && q.prev_time <= 1800) {
        thresholdDate.setDate(thresholdDate.getDate() + 7); // In a week
      } else if (q.prev_time <= 900) {
        thresholdDate.setDate(thresholdDate.getDate() + 14); // In two weeks
      }

      const today = new Date();
      today.setHours(0, 0, 0, 0);

      return thresholdDate <= today;
    });

    console.log("Filtered questions for repetition");

    const exploreQuery = `
    WITH UnsolvedQuestions AS (
      SELECT q.*
      FROM questions q
      WHERE NOT EXISTS (
        SELECT 1
        FROM user_question_history uh
        WHERE uh.question_id = q.id AND uh.user_id = $1
      )
    ),
    CategoryPriority AS (
      SELECT 
        uch.category,
        MIN(uch.last_solved) as last_solved_time
      FROM user_category_history uch
      WHERE uch.user_id = $1
      GROUP BY uch.category
      ORDER BY last_solved_time ASC, uch.category ASC
    ),
    PriorityQuestions AS (
      SELECT uq.*, cp.last_solved_time, ROW_NUMBER() OVER (PARTITION BY cp.category ORDER BY random()) as row_num
      FROM UnsolvedQuestions uq
      JOIN CategoryPriority cp ON uq.category = cp.category
    ),
    SelectedQuestions AS (
      SELECT *
      FROM PriorityQuestions
      WHERE row_num = 1
    ),
    FirstCategory AS (
      SELECT *
      FROM SelectedQuestions
      ORDER BY last_solved_time ASC
      LIMIT 1
    ),
    SecondCategory AS (
      SELECT *
      FROM SelectedQuestions
      WHERE category != (SELECT category FROM FirstCategory)
      ORDER BY last_solved_time ASC
      LIMIT 1
    )
    SELECT * FROM FirstCategory
    UNION ALL
    SELECT * FROM SecondCategory;
`;
    const { rows: exploreData } = await db.query(exploreQuery, [userId]);

    console.log("Fetched exploration data successfully.");

    res.status(200).json({ repetition: repeatQuestions, explore: exploreData });
  } catch (error) {
    res.status(500).send({ message: "Error fetching suggested questions." });
  }
};
exports.getAllQuestionsWithUserHistory = async (req, res) => {
  try {
    const userId = req.user.id;

    const questionsQuery = `
    SELECT q.*
    FROM questions q;
    `;

    const { rows: questionsData } = await db.query(questionsQuery);
    console.log("Fetched all questions successfully.");

    const userHistoryQuery = `
    SELECT uh.question_id, uh.prev_time, TO_CHAR(uh.last_solved, 'YYYY-MM-DD') AS last_solved
    FROM user_question_history uh
    WHERE uh.user_id = $1;
  `;

    const { rows: userHistoryData } = await db.query(userHistoryQuery, [
      userId,
    ]);
    console.log("Fetched user question history successfully.");

    const userHistoryMap = new Map();
    userHistoryData.forEach((history) => {
      userHistoryMap.set(history.question_id, {
        prev_time: history.prev_time,
        last_solved: history.last_solved,
      });
    });

    const enrichedQuestions = questionsData.map((question) => {
      const history = userHistoryMap.get(question.id);
      return {
        ...question,
        prev_time: history ? history.prev_time : null,
        last_solved: history ? history.last_solved : null,
      };
    });

    res.status(200).json(enrichedQuestions);
  } catch (error) {
    console.log("Error fetching questions with user history:");
    res
      .status(500)
      .send({ message: "Error fetching questions with user history." });
  }
};
exports.recordAttempt = async (req, res) => {
  const { startTime, endTime } = req.body;
  const { questionTitle } = req.params;
  const userId = req.user.id;
  try {
    const timeTaken = Math.floor(
      (new Date(endTime) - new Date(startTime)) / 1000
    );

    const questionQuery =
      "SELECT id, category FROM questions WHERE title = $1 LIMIT 1";
    const questionResult = await db.query(questionQuery, [questionTitle]);
    if (questionResult.rows.length === 0) {
      return res.status(404).send({ message: "Question not found." });
    }
    const questionId = questionResult.rows[0].id;
    const questionCategory = questionResult.rows[0].category;

    const checkQuery = `
      SELECT * FROM user_question_history
      WHERE user_id = $1 AND question_id = $2
      LIMIT 1;`;
    const checkResult = await db.query(checkQuery, [userId, questionId]);

    if (checkResult.rows.length > 0) {
      const updateQuery = `
        UPDATE user_question_history
        SET attempts = attempts + 1,
            prev_time = $3,
            last_solved = $4,
            pre15_attempts = CASE WHEN $3 <= 900 THEN pre15_attempts + 1 ELSE 0 END
        WHERE user_id = $1 AND question_id = $2;`;
      await db.query(updateQuery, [userId, questionId, timeTaken, new Date()]);
    } else {
      const insertQuery = `
        INSERT INTO user_question_history(user_id, question_id, attempts, pre15_attempts, prev_time, last_solved)
        VALUES ($1, $2, $3, $4, $5, $6);`;
      await db.query(insertQuery, [
        userId,
        questionId,
        1,
        timeTaken <= 900 ? 1 : 0,
        timeTaken,
        new Date(),
      ]);
    }
    const categoryUpdateQuery = `
      INSERT INTO user_category_history(user_id, category, last_solved)
      VALUES ($1, $2, $3)
      ON CONFLICT (user_id, category) DO UPDATE
      SET last_solved = EXCLUDED.last_solved;`;
    await db.query(categoryUpdateQuery, [userId, questionCategory, new Date()]);

    console.log("Recorded attempt successfully.");
    res.status(200).send({ message: "Attempt recorded successfully." });
  } catch (error) {
    console.log("Error recording attempt");
    res.status(500).send({ message: "Error recording attempt." });
  }
};
