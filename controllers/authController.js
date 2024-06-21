const bcrypt = require("bcrypt");
const admin = require("../config/firebaseConfig");
const db = require("../config/db");

exports.register = async (req, res) => {
  try {
    console.log("registering user");
    const { email, uid } = req.body;
    if (!email || !uid) {
      return res.status(400).send({ message: "Email and uid are required." });
    }

    // Insert new user into the users table
    const userInsertResult = await db.query(
      "INSERT INTO users (email, firebase_uid) VALUES ($1, $2) RETURNING id",
      [email, uid]
    );
    const userId = userInsertResult.rows[0].id;

    console.log(`User registered in backend: ${email}`);

    // Initialize user category history for all categories
    const categories = [
      "Arrays and Hashing",
      "Two Pointers",
      "Stack",
      "Binary Search",
      "Linked List",
      "Trees",
      "Tries",
      "Heap",
      "Intervals",
      "Greedy",
      "Graphs",
      "Backtracking",
      "Dynamic Programming",
    ];
    const initDate = new Date(0);

    for (const category of categories) {
      await db.query(
        "INSERT INTO user_category_history (user_id, category, last_solved) VALUES ($1, $2, $3)",
        [userId, category, initDate]
      );
    }

    res.status(201).send({
      message: "User registered successfully and categories initialized.",
    });
  } catch (error) {
    console.error("Error registering new user:", error.message, error.stack);
    res.status(500).send({ message: "Error registering new user." });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const { rows } = await db.query("SELECT * FROM users WHERE email = $1", [
      email,
    ]);
    const user = rows[0];
    if (user && (await bcrypt.compare(password, user.password_hash))) {
      const token = await admin.auth().createCustomToken(user.firebase_uid);

      res.status(200).send({ message: "Login successful.", token });
    } else {
      console.log(`Login attempt failed for user`);
      res.status(401).send({ message: "Invalid email or password." });
    }
  } catch (error) {
    console.error("Error logging in:", error.message, error.stack);
    res.status(500).send({ message: "Error logging in." });
  }
};

exports.logout = (req, res) => {
  // Firebase Authentication is stateless; logging out is handled client-side by removing the token
  console.log("Logout requested");
  res.status(200).send({ message: "Logout successful." });
};
