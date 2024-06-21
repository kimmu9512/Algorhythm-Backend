
CREATE TABLE IF NOT EXISTS user_category_history (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    category question_category NOT NULL,  
    last_solved TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);


CREATE UNIQUE INDEX IF NOT EXISTS idx_user_category ON user_category_history (user_id, category);
