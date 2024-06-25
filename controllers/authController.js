const bcrypt = require("bcrypt");
const admin = require("../config/firebaseConfig");
const db = require("../config/db");

exports.register = async (req, res) => {
  try {
    console.log("registering user");
    const { email, idToken } = req.body;
    //
    if (!email || !idToken) {
      console.log("Email and uid are required.");
      return res.status(400).send({ message: "Email and uid are required." });
    }
    let decodedToken;
    try {
      decodedToken = await admin.auth().verifyIdToken(idToken);
    } catch (error) {
      console.log("Invalid ID token.");
      return res.status(400).send({ message: "Invalid ID token." });
    }
    const uid = decodedToken.uid;
    if (decodedToken.email !== email) {
      console.log("Email and ID token do not match.");
      return res
        .status(400)
        .send({ message: "Email and ID token do not match." });
    }
    // Check if the user already exists in the database
    const existingUserResult = await db.query(
      "SELECT id FROM users WHERE email = $1",
      [email]
    );
    if (existingUserResult.rows.length > 0) {
      console.log("User already exists");
      return res.status(400).send({ message: "User already exists." });
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
exports.checkUser = async (req, res) => {
  try {
    const { email } = req.query;
    if (!email) {
      return res.status(400).send({ message: "Email is required." });
    }

    // Check if the user already exists in the database
    const existingUserResult = await db.query(
      "SELECT id FROM users WHERE email = $1",
      [email]
    );
    if (existingUserResult.rows.length > 0) {
      return res.status(200).send({ exists: true });
    } else {
      return res.status(200).send({ exists: false });
    }
  } catch (error) {
    console.error("Error checking user existence:", error.message, error.stack);
    res.status(500).send({ message: "Error checking user existence." });
  }
};
