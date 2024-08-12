-- Users Table
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    role ENUM('student', 'admin', 'moderator') DEFAULT 'student',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses Table
CREATE TABLE Courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    duration INT, -- in hours
    wtr_status ENUM('WTR', 'NTR') DEFAULT 'WTR',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Scholarships Table
CREATE TABLE Scholarships (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    eligibility_criteria TEXT,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Courses(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Applications Table
CREATE TABLE Applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    course_id INT,
    scholarship_id INT DEFAULT NULL,
    status ENUM('submitted', 'under review', 'accepted', 'rejected', 'documents_uploaded', 'finalized') DEFAULT 'submitted',
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id),
    FOREIGN KEY (scholarship_id) REFERENCES Scholarships(id)
);

-- Documents Table
CREATE TABLE Documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT,
    document_type ENUM('id', 'transcript', 'certificate', 'other'),
    file_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES Applications(id)
);
