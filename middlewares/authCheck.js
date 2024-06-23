const admin = require("../config/firebaseConfig");

const authCheck = async (req, res, next) => {
  try {
    console.log("Checking user authentication...");
    const idToken = req.headers.authorization?.split("Bearer ")[1];
    if (!idToken) {
      throw new Error("Failed to get token");
    }
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    req.decodedToken = decodedToken;
    console.log("User authenticated successfully.");

    next();
  } catch (error) {
    console.error("Error verifying token:", error.message, error.stack);
    return res.redirect("/auth/login");
  }
};

module.exports = authCheck;
