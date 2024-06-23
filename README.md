# Algorhythm

Algorhythm is a full-stack application designed to enhance the coding practice experience by providing users with a platform to solve LeetCode-like questions, track their progress, and receive personalized question recommendations. Users benefit from tailored suggestions that reinforce memory retention rather than rote learning. Repetition intervals are carefully selected to prevent users from memorizing specific algorithms, focusing instead on overarching techniques and skills required to approach and solve problems. By solving all the 'Explore' questions daily, users can effectively hone their problem-solving abilities.

## Overview

The architecture of Algorhythm is designed to ensure robustness, scalability, and a seamless user experience by leveraging a combination of powerful technologies. The backend is built with Node.js, chosen for its efficiency, scalability, and the vast ecosystem of modules and libraries that support rapid development. Node.js, with its non-blocking I/O and event-driven architecture, provides a highly performant environment capable of handling numerous simultaneous connections, making it ideal for real-time applications like Algorhythm.

Data persistence is managed by PostgreSQL, an advanced open-source relational database. PostgreSQL was selected for its reliability, data integrity, and support for advanced data types and performance optimization features. Its powerful querying capabilities and adherence to SQL standards make it an excellent choice for handling the complex data relationships inherent in tracking user progress, question metadata, and personalized recommendations.

To secure user accounts, Algorhythm utilizes Firebase Authentication. Firebase was chosen for its robust and secure authentication mechanisms, easy integration, and support for various authentication providers (such as email/password, Google, and others). By offloading the authentication process to Firebase, Algorhythm ensures that user credentials are handled securely, reducing the risk of security breaches and allowing me to focus on developing core functionalities.

## Features

- **Personalized Question Suggestions:** Users receive tailored question suggestions based on their performance. 'Repetition' questions are suggested based on the user's last performance to reinforce memory retention rather than rote learning, while 'Explore' questions are suggested based on when the user last solved each category.
- **Progress Tracking:** Users can see their previous attempt of how long it took to finish the question.
- **Admin Panel:** Admins can add new questions, categorize them, and upload solution videos.
- **Secure Authentication:** Utilizes Firebase Authentication for user account management.
- **Interactive Test Cases:** Users can add test cases to see what the solution should be and compare it with or without their code. This feature allows users to better understand the question or to compare the code result, highlighting differences from traditional platforms where a fully working solution is required for testing.

## Getting Started

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
