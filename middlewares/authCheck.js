const admin = require("../config/firebaseConfig");

const authCheck = async (req, res, next) => {
  try {
    console.log("Checking user authentication...");
    const idToken = req.headers.authorization?.split("Bearer ")[1];
    if (!idToken) {
      console.log("FAILED TO GET TOKEN");
      return res.redirect("/auth/login");
    }
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    req.decodedToken = decodedToken;
    console.log("User authenticated successfully.");

    next();
  } catch (error) {
    console.error("Error verifying token:");
    return res.redirect("/auth/login");
  }
};

module.exports = authCheck;
