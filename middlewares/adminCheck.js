const admin = require("../config/firebaseConfig");

const adminCheck = (req, res, next) => {
  try {
    const decodedToken = req.decodedToken;
    if (!decodedToken || !decodedToken.admin) {
      console.log("User is not an admin");
      return res.status(403).send("Access denied");
    }

    next();
  } catch (error) {
    console.error(
      "Error checking admin privileges:",
      error.message,
      error.stack
    );
    return res.status(500).send("Internal Server Error");
  }
};

module.exports = adminCheck;
