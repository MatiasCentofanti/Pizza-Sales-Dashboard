IF DB_ID('pizza_place') IS NULL
    CREATE DATABASE pizza_place;
GO

USE pizza_place;
GO

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(20) PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    category      VARCHAR(20)  NOT NULL,
    ingredients   VARCHAR(255)
);
GO

CREATE TABLE pizzas (
    pizza_id       VARCHAR(20) PRIMARY KEY,
    pizza_type_id  VARCHAR(20) NOT NULL,
    size           VARCHAR(5)  NOT NULL,
    price          DECIMAL(6,2) NOT NULL,
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
);
GO

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    [date]   DATE NOT NULL,
    [time]   TIME NOT NULL
);
GO

CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id         INT NOT NULL,
    pizza_id         VARCHAR(20) NOT NULL,
    quantity         INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);
GO

BULK INSERT pizza_types
FROM 'RUTA_A_TUS_CSV\pizza_types.csv'  -- reemplazá con la carpeta donde descargaste los CSV
WITH (
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

BULK INSERT pizzas
FROM 'RUTA_A_TUS_CSV\pizzas.csv'  -- reemplazá con la carpeta donde descargaste los CSV
WITH (
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

BULK INSERT orders
FROM 'RUTA_A_TUS_CSV\orders.csv'  -- reemplazá con la carpeta donde descargaste los CSV
WITH (
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

BULK INSERT order_details
FROM 'RUTA_A_TUS_CSV\order_details.csv'  -- reemplazá con la carpeta donde descargaste los CSV
WITH (
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO