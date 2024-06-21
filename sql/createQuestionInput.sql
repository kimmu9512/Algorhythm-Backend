CREATE TABLE IF NOT EXISTS question_inputs (
    id SERIAL PRIMARY KEY,
    question_id INTEGER NOT NULL,
    input_name VARCHAR(255) NOT NULL,
    example_value TEXT NOT NULL,
    input_order INTEGER NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    CONSTRAINT question_inputs_question_id_input_order_unique UNIQUE (question_id, input_order)
);