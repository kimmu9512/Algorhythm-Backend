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

// Serve static files in production
if (process.env.NODE_ENV === "production") {
  app.use(express.static("public"));
}

// Configure CORS
const corsOptions = {
  origin: process.env.CORS_ORIGIN || "*",
  optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));
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
// Uncomment this if you need to set admin privileges for a specific user
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
  if (process.env.NODE_ENV === "production") {
    res.status(500).send("Something broke!");
  } else {
    res.status(500).json({
      message: error.message,
      stack: error.stack,
    });
  }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running.`);
});
