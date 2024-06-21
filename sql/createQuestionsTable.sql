CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    category question_category NOT NULL,
    difficulty VARCHAR(50) NOT NULL,
    video_url VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    solution_code TEXT NOT NULL,
    default_code TEXT NOT NULL,
    method_name VARCHAR(255) NOT NULL
);