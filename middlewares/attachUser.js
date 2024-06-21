const db = require("../config/db");

const attachUser = async (req, res, next) => {
  try {
    const decodedToken = req.decodedToken;
    console.log(decodedToken);
    if (!decodedToken) {
      return res.status(401).send("Unauthorized");
    }

    const { rows } = await db.query(
      "SELECT * FROM users WHERE firebase_uid = $1",
      [decodedToken.uid]
    );
    const user = rows[0];
    req.user = user;
    console.log("atatched user ");
    console.log(user);
    next();
  } catch (error) {
    console.error("Error attaching user:", error.message, error.stack);
    return res.status(500).send("Internal Server Error");
  }
};

module.exports = attachUser;
