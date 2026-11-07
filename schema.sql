
DROP DATABASE IF EXISTS photography_mini;

CREATE DATABASE photography_mini
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE photography_mini;

CREATE TABLE photo_groups (
    group_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT pk_photo_groups PRIMARY KEY (group_id),
    CONSTRAINT uq_photo_groups_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE photographers (
    photographer_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    group_id INT NOT NULL,
    CONSTRAINT pk_photographers PRIMARY KEY (photographer_id),
    CONSTRAINT uq_photographers_email UNIQUE (email),
    CONSTRAINT fk_photographers_group FOREIGN KEY (group_id)
        REFERENCES photo_groups (group_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE clients (
    client_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL,
    CONSTRAINT pk_clients PRIMARY KEY (client_id),
    CONSTRAINT uq_clients_phone UNIQUE (phone),
    CONSTRAINT uq_clients_email UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE shoots (
    shoot_id INT NOT NULL,
    client_id INT NOT NULL,
    photographer_id INT NOT NULL,
    shoot_date DATE NOT NULL,
    status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
    location VARCHAR(255) NOT NULL,
    CONSTRAINT pk_shoots PRIMARY KEY (shoot_id),
    CONSTRAINT fk_shoots_client FOREIGN KEY (client_id)
        REFERENCES clients (client_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_shoots_photographer FOREIGN KEY (photographer_id)
        REFERENCES photographers (photographer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_shoots_status CHECK (status IN ('Pending', 'Completed', 'Cancelled'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE deliveries (
    delivery_id INT NOT NULL,
    shoot_id INT NOT NULL,
    delivered_at DATE NOT NULL,
    photo_count INT NOT NULL,
    album_link VARCHAR(255) NOT NULL,
    fee DECIMAL(12, 2) NOT NULL,
    CONSTRAINT pk_deliveries PRIMARY KEY (delivery_id),
    CONSTRAINT uq_deliveries_shoot UNIQUE (shoot_id),
    CONSTRAINT fk_deliveries_shoot FOREIGN KEY (shoot_id)
        REFERENCES shoots (shoot_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_deliveries_photo_count CHECK (photo_count > 0),
    CONSTRAINT chk_deliveries_fee CHECK (fee >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE payments (
    payment_id INT NOT NULL,
    shoot_id INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    payment_date DATE NOT NULL,
    method ENUM('Cash', 'BankTransfer', 'Card') NOT NULL,
    CONSTRAINT pk_payments PRIMARY KEY (payment_id),
    CONSTRAINT fk_payments_shoot FOREIGN KEY (shoot_id)
        REFERENCES shoots (shoot_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_payments_amount CHECK (amount > 0),
    CONSTRAINT chk_payments_method CHECK (method IN ('Cash', 'BankTransfer', 'Card'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
