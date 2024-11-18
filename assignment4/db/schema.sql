CREATE TABLE IF NOT EXISTS Seller (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    seller INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seller) REFERENCES Seller(id)
);

ALTER SEQUECE seller_id_seq RESTART WITH 1;
ALTER SEQUECE product_id_seq RESTART WITH 1;

-- DUMMY DATA 
INSERT INTO Seller (name) VALUES 
('John Doe'),
('Jane Smith'),
('Acme Corp'),
('Global Traders'),
('Tech Ventures');

INSERT INTO Product (name, seller, price) VALUES
('Laptop', 1, 899.99),
('Smartphone', 1, 699.99),
('Office Chair', 2, 129.50),
('Desk Lamp', 2, 45.00),
('Gaming Console', 3, 499.99),
('Wireless Earbuds', 3, 149.99),
('Bluetooth Speaker', 4, 79.99),
('Tablet', 4, 329.99),
('Smartwatch', 5, 249.99),
('Keyboard', 5, 49.99);
