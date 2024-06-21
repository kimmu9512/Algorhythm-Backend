const fs = require("fs");
const path = require("path");
const pool = require("./db");

const sqlFiles = [
  "createUsersTable.sql",
  "createQuestionsTable.sql",
  "createQuestionCategory.sql",
  "createQuestionCategoryHistory.sql",
  "createQuestionInput.sql",
  "createUserQuestionHistoryTable.sql",
];

async function executeSQLFiles() {
  const client = await pool.connect();
  try {
    for (const file of sqlFiles) {
      const filePath = path.join(__dirname, "..", "sql", file);
      const sql = fs.readFileSync(filePath, "utf-8");

      const objectName = extractObjectName(sql);
      if (!objectName) {
        continue;
      }

      const objectExists = await checkObjectExists(client, objectName);

      if (!objectExists) {
        await client.query(sql);
      }
    }
  } catch (err) {
  } finally {
    client.release();
  }
}

function extractObjectName(sql) {
  const tableMatch = sql.match(/CREATE TABLE IF NOT EXISTS (\w+)/i);
  const typeMatch = sql.match(/CREATE TYPE (\w+)/i);
  return tableMatch
    ? tableMatch[1].toLowerCase()
    : typeMatch
    ? typeMatch[1].toLowerCase()
    : null;
}

async function checkObjectExists(client, objectName) {
  const tableExistsQuery = `
    SELECT EXISTS (
      SELECT FROM information_schema.tables 
      WHERE table_name = $1
    )`;
  const typeExistsQuery = `
    SELECT EXISTS (
      SELECT FROM pg_type 
      WHERE typname = $1
    )`;

  const tableExistsRes = await client.query(tableExistsQuery, [objectName]);
  if (tableExistsRes.rows[0].exists) {
    return true;
  }

  const typeExistsRes = await client.query(typeExistsQuery, [objectName]);
  return typeExistsRes.rows[0].exists;
}

module.exports = executeSQLFiles;
