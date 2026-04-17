CREATE DATABASE IF NOT EXISTS movieflix_db;
USE movieflix_db;


/* ---------- GENRE TABLE ---------- */
CREATE TABLE genre (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) UNIQUE NOT NULL,
    description TEXT
);


/* ---------- USER TABLE ---------- */
CREATE TABLE app_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60),
    email VARCHAR(120) UNIQUE
);


/* ---------- SUBSCRIPTION PLAN ---------- */
CREATE TABLE subscriptionplan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL UNIQUE,
    price DECIMAL(10,2),
    duration_days INT,
    max_devices INT
);


/* ---------- MOVIE TABLE ---------- */
CREATE TABLE movie (
    id INT AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    release_date DATE,
    duration INT,
    genre_id INT,
    rating DECIMAL(3,1),
    language VARCHAR(30),
    is_premium BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),

    CONSTRAINT fk_movie_genre
    FOREIGN KEY (genre_id) 
    REFERENCES genre(id)
    ON DELETE CASCADE
);


/* ---------- USER SUBSCRIPTION ---------- */
CREATE TABLE usersubscription (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    plan_id INT,
    start_date DATETIME,
    end_date DATETIME,
    status VARCHAR(25),

    CONSTRAINT fk_user_sub_user
    FOREIGN KEY (user_id) REFERENCES app_user(id),

    CONSTRAINT fk_user_sub_plan
    FOREIGN KEY (plan_id) REFERENCES subscriptionplan(id)
);


/* ---------- WATCHLIST ---------- */
CREATE TABLE watchlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_watch_user
    FOREIGN KEY (user_id) REFERENCES app_user(id),

    CONSTRAINT fk_watch_movie
    FOREIGN KEY (movie_id) REFERENCES movie(id),

    CONSTRAINT unique_watch UNIQUE(user_id, movie_id)
);


/* ---------- REVIEW ---------- */
CREATE TABLE review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    rating DECIMAL(3,1) NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_review_user
    FOREIGN KEY (user_id) REFERENCES app_user(id),

    CONSTRAINT fk_review_movie
    FOREIGN KEY (movie_id) REFERENCES movie(id),

    UNIQUE(user_id, movie_id)
);


/* ---------- LIKE / DISLIKE ---------- */
CREATE TABLE reaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    reaction ENUM('like','dislike') NOT NULL,

    CONSTRAINT fk_react_user
    FOREIGN KEY (user_id) REFERENCES app_user(id),

    CONSTRAINT fk_react_movie
    FOREIGN KEY (movie_id) REFERENCES movie(id),

    UNIQUE(user_id, movie_id)
);