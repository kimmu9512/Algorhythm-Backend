# Algorhythm

Algorhythm is a full-stack application designed to enhance the coding practice experience by providing users with a platform to solve LeetCode-like questions, track their progress, and receive personalized question recommendations. Users benefit from tailored suggestions that reinforce memory retention rather than rote learning. Repetition intervals are carefully selected to prevent users from memorizing specific algorithms, focusing instead on overarching techniques and skills required to approach and solve problems. By solving all the 'Explore' questions daily, users can effectively hone their problem-solving abilities.

## Features

- **Personalized Question Suggestions:** Users receive tailored question suggestions based on their performance. 'Repetition' questions are suggested based on the user's last performance to reinforce memory retention rather than rote learning, while 'Explore' questions are suggested based on when the user last solved each category.
- **Progress Tracking:** Users can see their previous attempt of how long it took to finish the question.
- **Admin Panel:** Admins can add new questions, categorize them, and upload solution videos.
- **Secure Authentication:** Utilizes Firebase Authentication for user account management.
- **Interactive Test Cases:** Users can add test cases to see what the solution should be and compare it with or without their code. This feature allows users to better understand the question or to compare the code result, highlighting differences from traditional platforms where a fully working solution is required for testing.

## Algorhythm-Backend

### Overview

Welcome to the backend server repository/documentation for **Algorhythm**. This backend server is responsible for handling API requests, managing the database, and providing secure authentication. It is built with Node.js and PostgreSQL, ensuring a scalable and efficient solution for our application.

### Table of Contents

1. [Architecture Decisions](#architecture-decisions)
2. [Getting Started](#getting-started)
3. [Project Structure](#project-structure)
4. [API Endpoints](#api-endpoints)
5. [Database Schema](#database-schema)

### Architecture Decisions

The architecture of Algorhythm is designed to ensure robustness, scalability, and a seamless user experience by leveraging a combination of powerful technologies. The backend is built with Node.js, chosen for its efficiency, scalability, and the vast ecosystem of modules and libraries that support rapid development. Node.js, with its non-blocking I/O and event-driven architecture, provides a highly performant environment capable of handling numerous simultaneous connections, making it ideal for real-time applications like the Algorhythm backend. Additionally, the backend follows a RESTful architecture, ensuring a clear, stateless, and standardized interface for client-server communication, which enhances maintainability and scalability.

Data persistence is managed by PostgreSQL, an advanced open-source relational database. PostgreSQL was selected for its reliability, data integrity, and support for advanced data types and performance optimization features. Its powerful querying capabilities and adherence to SQL standards make it an excellent choice for handling the complex data relationships inherent in tracking user progress, question metadata, and personalized recommendations.

To secure user accounts, Algorhythm utilizes Firebase Authentication. Firebase was chosen for its robust and secure authentication mechanisms, easy integration, and support for various authentication providers (such as email/password, Google, and others). By offloading the authentication process to Firebase, Algorhythm ensures that user credentials are handled securely, reducing the risk of security breaches and allowing me to focus on developing core functionalities.

For the frontend, Vite was chosen over other technologies due to its superior development experience and performance benefits. Vite provides a fast and efficient development server with hot module replacement (HMR), ensuring rapid feedback during development. Its native ES module support allows for faster builds and smaller bundles, optimizing the overall performance of the application. Vite’s compatibility with popular frontend frameworks and its minimal configuration requirements make it an ideal choice for modern web development, ensuring a smooth and efficient development workflow for the Algorhythm frontend.

### Getting Started

#### Prerequisites

- Node.js (version 14 or higher)
- PostgreSQL ( uses the pg library version 8.11.3 to connect to PostgreSQL. Ensure that your PostgreSQL server version is compatible with this library.)

#### Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/kimmu9512/Algorhythm-Backend.git
   cd Algorhythm-Backend
   ```

2. Install dependencies:

   ```sh
   npm install
   ```

3. Set up the environment variables:
   Create a `.env` file in the root directory and add a copy contents of .env.example and fill it in with your own. For detailed instructions on what values to use, refer to the [environment configuration guide](https://github.com/kimmu9512/Algorhythm-Backend/wiki/Configuring-environment-variables).

4. Initialize the database:
   Ensure PostgreSQL is installed and running on your machine.

5. Run the `dump.sql` file:
   Use the following command to execute the `dump.sql` file and set up your database.

   ```sh
   psql -U your_username -d your_database -f path/to/dump.sql
   ```

   Replace `your_username` with your PostgreSQL username, `your_database` with the name of your database, and `path/to/dump.sql` with the relative path to the `dump.sql` file.
   This will populate your database with sample questions.

   **Note:** If you prefer to create your own questions instead of using the sample questions, you can skip this step and directly start the development server as mentioned below.

6. Start the development server:

   ```sh
   npm start
   ```

### Project Structure

The project is organized as follows:
The repository is organized into several directories and files, each serving a specific purpose to ensure modularity, scalability, and maintainability of the codebase.

#### Root Directory

- **server.js**: The main entry point of the application. It initializes the server and sets up the necessary middleware and routes.
- **package.json**: Contains metadata about the project and lists dependencies, scripts, and other configurations.
- **package-lock.json**: Automatically generated file that locks the versions of the project's dependencies.
- **.env**: Environment variables configuration file (not included in the repository for security reasons).
- **.env.example**: Example environment variables file to help new developers set up their environment.
- **.gitignore**: Specifies which files and directories should be ignored by Git.
- **README.md**: Provides an overview of the project, including installation instructions, usage, and other relevant information.

#### Config Directory

Contains configuration files for various services and settings.

- **db.js**: Database configuration and connection setup.
- **executeSQLFiles.js**: Utility to execute SQL files for database setup or migrations.
- **firebaseConfig.js**: Configuration for Firebase services.

#### Controllers Directory

Houses the controller logic for handling incoming requests and interacting with services and the database.

- **adminController.js**: Contains functions related to only admin allowed functions ( creating questions )
- **authController.js**: Handles authentication-related operations.
- **judgeController.js**: Manages the logic for judging code submissions.
- **questionController.js**:Handles operations related to questions, including retrieval, suggesting questions based on user performance history, recording user attempts, and providing enriched question data with user history for the Algorhythm project.

#### Middlewares Directory

Contains middleware functions that are used to process requests before reaching the controllers.

- **adminCheck.js**: Middleware to verify if the user has admin privileges.
- **attachUser.js**: Middleware to attach the authenticated user to the request object.
- **authCheck.js**: Middleware to check if the user is authenticated.

### Resources Directory

Contains resources that are used by the application but are not part of the core logic.

- **predefined_code.py**: Predefined Python code snippet used within the application to attach to users’ code to make it executable in the Judge API.

#### Routes Directory

Defines the application's API routes, mapping HTTP methods and endpoints to controller functions.

- **adminRoutes.js**: Routes for admin-related operations.
- **authRoutes.js**: Routes for authentication-related operations.
- **judgeRoutes.js**: Routes for judging code submissions.
- **questionRoutes.js**: Routes for managing questions.

### SQL Directory

Contains SQL files used for database setup and migrations.

- **createQuestionCategory.sql**: SQL script for creating the `QuestionCategory` table.
- **createQuestionCategoryHistory.sql**: SQL script for creating the `QuestionCategoryHistory` table.
- **createQuestionInput.sql**: SQL script for creating the `QuestionInput` table.
- **createQuestionsTable.sql**: SQL script for creating the `Questions` table.
- **createUserQuestionHistoryTable.sql**: SQL script for creating the `UserQuestionHistory` table.
- **createUsersTable.sql**: SQL script for creating the `Users` table.

#### Utils Directory

Contains utility functions and helpers used throughout the application.

- **helpers.js**: Contains a helper function that creates Python code for the Judge API using a predefined template based on the provided function name and test cases.

#### Other Files

- **dump.sql**: SQL dump file for database backup or initialization (if applicable).

This project structure is designed to follow best practices and principles such as modularity, separation of concerns, and maintainability, making it easier for developers to navigate and contribute to the project.

### API Endpoints

#### Authentication Endpoints

**Base URL: `/auth`**

##### 1. Register User

- **Endpoint:** `POST /register`
- **Description:** Registers a new user with their email and UID after Firebase has registered the user. The backend verifies the ID token with Firebase, checks if the user already exists, and then registers the new user and initializes category history.
- **Request Body:**
  - `email`: User's email (string)
  - `idToken`: User's Firebase ID token(string)
- **Response:**
  - **Success:** 201 Created
  - **Failure:** 400 Bad Request, 500 Internal Server Error

> **Note:** There was no need to implement login or logout functionality on the backend. Firebase Authentication handles user authentication, including login and logout, ensuring secure management of user sessions.

#### Admin Endpoints

**Base URL: `/admin`**

##### 1. Add Question

- **Endpoint:** `POST /add-question`
- **Middleware:** `authCheck`, `attachUser`, `adminCheck`
- **Description:** Adds a new coding question. The user must be authenticated and have admin privileges to use this endpoint.
- **Request Body:**
  - `descriptionValues`
    - `description`: Question description
    - `functionName`: Function name
    - `questionTitle`: Question title
    - `selectedCategory`: Selected category
    - `selectedDifficulty`: Selected difficulty
    - `videoUrl`: Video URL
  - `interactionValues`
    - `code`: Solution code
    - `testCases`: Array of test cases, each containing name and value. The value represents parameter values for the function, and no result is needed. Test cases are required to provide users with example parameter values.
- **Response:**
  - **Success:** 201 Created
  - **Failure:** 400 Bad Request, 500 Internal Server Error

#### Question Endpoints

**Base URL: `/questions`**

##### 1. Get Random Question

- **Endpoint:** `GET /random`
- **Description:** Fetches a random question from the pool of questions in the database.
- **Response:** - **Status Code:** 200 OK - **Body:**

  ````json
  {
  "id": 1,
  "title": "Two Sum",
  "category": "array",
  "difficulty": "easy",
  "video_url": "http://example.com/video",
  "description": "<p>Given an array of integers ...</p>",
  "solution_code": "def two_sum(nums, target): ...",
  "default_code": "def two_sum(nums, target):",
  "method_name": "two_sum"
  }
      ```
  ````

###### 2. Get Suggested Questions

- **Endpoint:** `GET /suggestions`
- **Middleware:** `authCheck`, `attachUser`
- **Description:** Fetches suggested questions for the authenticated user.The user must be authenticated
- **Response:**
  - **Success:** 200 OK
  - **Failure:** 500 Internal Server Error

##### 3. Get User Questions

- **Endpoint:** `GET /user-questions`
- **Middleware:** `authCheck`, `attachUser`
- **Description:** Fetches all questions along with user history.
- **Response:**
  - **Success:** 200 OK
  - **Failure:** 500 Internal Server Error

##### 4. Get Question by ID

- **Endpoint:** `GET /:id`
- **Description:** Fetches a question by its ID.
- **Response:**
  - **Success:** 200 OK
  - **Failure:** 404 Not Found, 500 Internal Server Error

##### 5. Get Question Input

- **Endpoint:** `GET /input/:id`
- **Description:** Fetches input for a specific question.
- **Response:**
  - **Success:** 200 OK
  - **Failure:** 500 Internal Server Error

##### 6. Record Attempt

- **Endpoint:** `POST /attempt/:questionTitle`
- **Middleware:** `authCheck`, `attachUser`
- **Description:** Records an attempt for a specific question.
- **Request Body:**
  - `startTime`: Start time of the attempt
  - `endTime`: End time of the attempt
- **Response:**
  - **Success:** 200 OK
  - **Failure:** 404 Not Found, 500 Internal Server Error

#### Judge Endpoints

**Base URL: `/judge`**

##### 1. Submit Code for Evaluation

- **Endpoint:** `POST /submit`
- **Middleware:** `authCheck`, `attachUser`
- **Description:** Submits code for results on test case on user's code from Judge0
- **Request Body:**
  - `language_id`: ID of the programming language
  - `source_code`: Source code to be evaluated
  - `inputs`: Array of inputs for the code
  - `question_id`: ID of the question
- **Response:**
  - **Success:** 200 OK
  - **Failure:** 500 Internal Server Error

##### 2. Submit Solution for Expected Output

- **Endpoint:** `POST /solution/:questionId`
- **Middleware:** `authCheck`, `attachUser`
- **Description:** Submits solution code for a specific test case to get the expected output.
- **Request Body:**
  - `inputs`: Array of inputs for the solution
- **Response:**
  - **Success:** 200 OK
  - **Failure:** 404 Not Found, 500 Internal Server Error

### Database Schema

#### Schema Diagram

Below is the diagram representing the database schema. This visual aid helps in understanding the relationships between different tables and the overall structure of the database.
![Database Schema Diagram](https://github.com/kimmu9512/Algorhythm-Backend/assets/84740321/1748715e-160f-4dfa-aed4-a8188d68432f)

#### Tables

##### Users

| Column       | Data Type    | Constraints      | Description                          |
| ------------ | ------------ | ---------------- | ------------------------------------ |
| id           | SERIAL       | PRIMARY KEY      | Unique identifier for each user      |
| email        | VARCHAR(255) | UNIQUE, NOT NULL | User's email address                 |
| firebase_uid | VARCHAR(255) | NOT NULL         | Firebase UID for user authentication |

##### Questions

| Column        | Data Type         | Constraints      | Description                             |
| ------------- | ----------------- | ---------------- | --------------------------------------- |
| id            | SERIAL            | PRIMARY KEY      | Unique identifier for each question     |
| title         | VARCHAR(255)      | UNIQUE, NOT NULL | Title of the question                   |
| category      | question_category | NOT NULL         | Category of the question                |
| difficulty    | VARCHAR(50)       | NOT NULL         | Difficulty level of the question        |
| video_url     | VARCHAR(255)      | NOT NULL         | URL to the question's video explanation |
| description   | TEXT              | NOT NULL         | Detailed description of the question    |
| solution_code | TEXT              | NOT NULL         | Solution code for the question          |
| default_code  | TEXT              | NOT NULL         | Default code template for the question  |
| method_name   | VARCHAR(255)      | NOT NULL         | Name of the method to be implemented    |

##### Question Inputs

| Column                                                                                      | Data Type    | Constraints | Description                          |
| ------------------------------------------------------------------------------------------- | ------------ | ----------- | ------------------------------------ |
| id                                                                                          | SERIAL       | PRIMARY KEY | Unique identifier for each input     |
| question_id                                                                                 | INTEGER      | NOT NULL    | Reference to the associated question |
| input_name                                                                                  | VARCHAR(255) | NOT NULL    | Name of the input                    |
| example_value                                                                               | TEXT         | NOT NULL    | Example value for the input          |
| input_order                                                                                 | INTEGER      | NOT NULL    | Order of the input                   |
| FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE                        |              |             |                                      |
| CONSTRAINT question_inputs_question_id_input_order_unique UNIQUE (question_id, input_order) |              |             |                                      |

#### User Question History

| Column                                              | Data Type | Constraints | Description                                 |
| --------------------------------------------------- | --------- | ----------- | ------------------------------------------- |
| id                                                  | SERIAL    | PRIMARY KEY | Unique identifier for each history record   |
| user_id                                             | INTEGER   | NOT NULL    | Reference to the associated user            |
| question_id                                         | INTEGER   | NOT NULL    | Reference to the associated question        |
| attempts                                            | INTEGER   | NOT NULL    | Number of attempts made by the user         |
| pre15_attempts                                      | INTEGER   | NOT NULL    | Attempts made within the last 15 days       |
| prev_time                                           | INTEGER   | NOT NULL    | Time taken for the previous attempt         |
| last_solved                                         | TIMESTAMP | NOT NULL    | Timestamp when the question was last solved |
| FOREIGN KEY (user_id) REFERENCES users (id)         |           |             |                                             |
| FOREIGN KEY (question_id) REFERENCES questions (id) |           |             |                                             |

#### User Category History

| Column                                                                             | Data Type         | Constraints | Description                                 |
| ---------------------------------------------------------------------------------- | ----------------- | ----------- | ------------------------------------------- |
| id                                                                                 | SERIAL            | PRIMARY KEY | Unique identifier for each history record   |
| user_id                                                                            | INTEGER           | NOT NULL    | Reference to the associated user            |
| category                                                                           | question_category | NOT NULL    | Category associated with the history record |
| last_solved                                                                        | TIMESTAMP         | NOT NULL    | Timestamp when the category was last solved |
| FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE                      |                   |             |                                             |
| CREATE UNIQUE INDEX idx_user_category ON user_category_history (user_id, category) |                   |             |                                             |

#### Relationships

- **Users** and **Questions**: One-to-Many relationship where a user can solve multiple questions.
  - `Users.id` (PK) ↔ `UserQuestionHistory.user_id` (FK)
  - `Questions.id` (PK) ↔ `UserQuestionHistory.question_id` (FK)

#### Indexes

- **Users**
  - `email_index` on `email`
- **Questions**
  - `title_index` on `title`

#### Constraints

- **Users**
  - `email` must be unique.
  - `firebase_uid` cannot be null.
- **Questions**
  - `title` must be unique and cannot be null.
  - `category`, `difficulty`, `video_url`, `description`, `solution_code`, `default_code`, and `method_name` cannot be null.

### License
