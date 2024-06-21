CREATE TABLE IF NOT EXISTS user_question_history (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    attempts INTEGER NOT NULL,
    pre15_attempts INTEGER NOT NULL,
    prev_time INTEGER NOT NULL,
    last_solved TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (question_id) REFERENCES questions (id)
);