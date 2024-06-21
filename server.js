const express = require("express");
const cors = require("cors");
const executeSQLFiles = require("./config/executeSQLFiles");
const admin = require("./config/firebaseConfig");
const authRoutes = require("./routes/authRoutes");
const questionRoutes = require("./routes/questionRoutes");
const adminRoutes = require("./routes/adminRoutes");
const judgeRoutes = require("./routes/judgeRoutes");
require("dotenv").config();

const app = express();

// Middleware setup
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(cors({ origin: process.env.CORS_ORIGIN }));

// Execute SQL files
executeSQLFiles()
  .then(() => {
    console.log("SQL file execution completed");
  })
  .catch((err) => {
    console.error("Error during SQL file execution:", err);
  });

// Function to set admin privileges
function setAdminPrivileges(userId) {
  admin
    .auth()
    .setCustomUserClaims(userId, { admin: true })
    .then(() => console.log("Admin privileges granted to user"))
    .catch((error) => console.error("Error setting admin claims:", error));
}

// Set admin privileges for a specific user
setAdminPrivileges(process.env.ADMIN_USER_ID);

// Route handlers
app.use("/auth", authRoutes); // Authentication routes (login, logout, register)
app.use("/questions", questionRoutes); // Question-related routes (viewing questions, user-related questions)
app.use("/admin", adminRoutes); // Admin routes (adding questions)
app.use("/judge", judgeRoutes); // Judge routes (submitting code, solutions)

// Error handling middleware
app.use((error, req, res, next) => {
  console.error("Error", error.message, error.stack);
  res.status(500).send("Something broke!");
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running.`);
});
