# Algorhythm

Algorhythm is a full-stack application designed to enhance the coding practice experience by providing a platform for users to solve LeetCode questions, track their progress, and receive personalized question recommendations. The application integrates Node.js, Express, PostgreSQL, and Firebase Authentication to create a robust and secure environment for users to improve their coding skills.

## Overview

The architecture of Algorhythm leverages Node.js and Express for the backend, with PostgreSQL handling data persistence. Firebase Authentication is used to secure user accounts and personalize user experiences. The application suggests LeetCode questions to users based on their solving history and preferences, categorizing suggestions into 'Repetition' for practice and 'Explore' for discovering new challenges.

## Features

- **Personalized Question Suggestions:** Users receive tailored question suggestions based on their performance and preferences.
- **Progress Tracking:** Users can track their attempt history, including best times for solved questions.
- **Customizable Practice:** Users can select or deselect question categories for personalized recommendations.
- **Admin Panel:** Admins can add new questions, categorize them, and upload solution videos.
- **Secure Authentication:** Utilizes Firebase Authentication for user account management.

## Getting started

### Requirements

- Node.js
- PostgreSQL
- Firebase account for setting up Firebase Authentication

### Quickstart

1. Clone the repository to your local machine.
2. Install dependencies with `npm install`.
3. Set up the PostgreSQL database and Firebase Authentication according to the provided configuration files.
4. Start the application with `npm start`.
5. Navigate to `http://localhost:3000` to access Algorhythm.

### License

Copyright (c) 2024.