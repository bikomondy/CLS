use labs;
show tables

-- Create User Table
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('student', 'faculty') NOT NULL
);

-- Create Course Table
CREATE TABLE Course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(10) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES User(user_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create Lab Table
CREATE TABLE Lab (
    lab_id INT PRIMARY KEY AUTO_INCREMENT,
    lab_name VARCHAR(50) NOT NULL
);

-- Create Timetable Table
CREATE TABLE Timetable (
    timetable_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    lab_id INT,
    day_of_week VARCHAR(10) NOT NULL,
    time_slot VARCHAR(10) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (lab_id) REFERENCES Lab(lab_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Cancellation Table
CREATE TABLE Cancellation (
    cancellation_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    lab_id INT,
    day_of_week VARCHAR(10) NOT NULL,
    time_slot VARCHAR(10) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (lab_id) REFERENCES Lab(lab_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Inserting Users
INSERT INTO User (user_id, username, password_hash, role) VALUES
    (1, 'Michael M Mwebesa', 'hashed_password', 'student'),
    (2, 'Bikolimana Diamond', 'hashed_password', 'student'),
    (3, 'Anthony Peres', 'hashed_password', 'student'),
    (4, 'Sadic Hamad', 'hashed_password', 'student'),
    (5, 'Omar Salum', 'hashed_password', 'student'),
    (6, 'Mr Tende', 'hashed_password', 'faculty'),
    (7, 'Mr. Edward', 'hashed_password', 'faculty');

-- Courses
INSERT INTO Course (course_code, course_name, faculty_id) VALUES
    ('CS101', 'Introduction to Computer Science', 6),
    ('MATH202', 'Calculus II', 7),
    ('ENG101', 'English Composition', 7),
    ('PHY301', 'Physics for Computer Scientists', 6);

-- Labs
INSERT INTO Lab (lab_name) VALUES
    ('Lab A'),
    ('Lab B'),
    ('Lab C'),
    ('Lab D');

-- Timetable (Random assignments for the existing courses and labs)
INSERT INTO Timetable (course_id, lab_id, day_of_week, time_slot) VALUES
    (1, 1, 'Monday', 'Morning'),
    (2, 2, 'Tuesday', 'Afternoon'),
    (3, 3, 'Wednesday', 'Evening'),
    (4, 4, 'Thursday', 'Morning');

-- Cancellations (Random cancellations for the existing timetable)
INSERT INTO Cancellation (course_id, lab_id, day_of_week, time_slot) VALUES
    (1, 1, 'Monday', 'Morning');
