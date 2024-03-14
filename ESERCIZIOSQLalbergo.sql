CREATE TABLE Albergo (
	albergoID INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    indirizzo VARCHAR(255) NOT NULL,
    valutazione INT NOT NULL CHECK (valutazione BETWEEN 1 AND 5),
);
CREATE TABLE Camera (
	cameraID INT PRIMARY KEY IDENTITY(1,1),
    numero INT NOT NULL,
    tipo VARCHAR (50) NOT NULL,
    capacitaMassima INT NOT NULL,
    tariffaPerNotte DECIMAL(10, 2) NOT NULL,
    albergoRIF INT NOT NULL,
    FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID),
);

CREATE TABLE Cliente (
    clienteID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100) NOT NULL,
    cognome NVARCHAR(100) NOT NULL ,
    contatto NVARCHAR(100) NOT NULL,
);
CREATE TABLE Prenotazione (
    prenotazioneID INT PRIMARY KEY IDENTITY (1,1),
    dataCheckIn DATE NOT NULL,
    dataCheckOut DATE NOT NULL,
    cameraRIF INT NOT NULL,
    clienteRIF INT NOT NULL,
    FOREIGN KEY (cameraRIF) REFERENCES Camera(cameraID),
    FOREIGN KEY (clienteRIF) REFERENCES Cliente(clienteID),
);
CREATE TABLE Dipendente (
    dipendenteID INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    posizione VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    albergoRIF INT NOT NULL,
    FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
);
CREATE TABLE Facility (
	facilityID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    descrizione VARCHAR(255) NOT NULL,
    orariApertura VARCHAR(100) NOT NULL,
    albergoRIF INT NOT NULL,
    FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID)ON DELETE CASCADE,
);


INSERT INTO Albergo (nome, indirizzo, valutazione)VALUES
	('Hotel Bella Vista', 'Via Roma 123, Roma', 4),
    ('Grand Hotel Paradiso', 'Corso Italia 456, Milano', 5),
    ('Hotel Mare Blu', 'Lungomare 789, Napoli', 3);

INSERT INTO Camera (numero, tipo, capacitaMassima, tariffaPerNotte, albergoRIF)VALUES 
    (101, 'Singola', 1, 100.00, 1),
    (202, 'Doppia', 2, 150.00, 1),
    (303, 'Suite', 4, 250.00, 2),
    (404, 'Matrimoniale', 2, 180.00, 2),
    (505, 'Tripla', 3, 200.00, 3);

--Prova a inserire due stanze con stesso numero in alberghi diversi con caratteristiche diverse
INSERT INTO Camera (numero, tipo, capacitaMassima, tariffaPerNotte, albergoRIF)VALUES
    (101, 'Singola', 1, 100.00, 1);

-- Seconda stanza con lo stesso numero in albergo 2
INSERT INTO Camera (numero, tipo, capacitaMassima, tariffaPerNotte, albergoRIF)VALUES 
    (101, 'Doppia', 2, 150.00, 2);

INSERT INTO Cliente (Nome, cognome, contatto)VALUES 
	('Mario', 'Rossi', 'mario.rossi@example.com'),
    ('Laura', 'Bianchi', 'laura.bianchi@example.com'),
    ('Marco', 'Verdi', 'marco.verdi@example.com'),
    ('Francesca', 'Neri', 'francesca.neri@example.com'),
    ('Giovanni', 'Gialli', 'giovanni.gialli@example.com');

INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, cameraRIF, clienteRIF)VALUES 
    ('2024-03-15', '2024-03-20', 1, 1),
    ('2024-04-10', '2024-04-15', 3, 2),
    ('2024-05-01', '2024-05-05', 5, 3);

--Prova a prenotare due stanze con lo stesso numero in alberghi diversi nella stessa data
INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, cameraRIF, clienteRIF)VALUES 

	('2024-03-20', '2024-03-25', 
    (SELECT cameraID FROM Camera WHERE numero = 101 AND albergoRIF = 1), 
     1);

-- Seconda prenotazione
INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, cameraRIF, clienteRIF)VALUES 
	('2024-03-20', '2024-03-25', 
    (SELECT cameraID FROM Camera WHERE numero = 101 AND albergoRIF = 2), 
     2);


INSERT INTO Dipendente (nome, cognome, posizione, email, albergoRIF)VALUES 
    ('Paolo', 'Bianchi', 'Receptionist', 'paolo.bianchi@example.com', 1),
    ('Anna', 'Verdi', 'Manager', 'anna.verdi@example.com', 2),
    ('Luca', 'Rossi', 'Pulizie', 'luca.rossi@example.com', 3),
    ('Maria', 'Gialli', 'Receptionist', 'maria.gialli@example.com', 1);


INSERT INTO Facility (Nome, descrizione, orariApertura, albergoRIF)VALUES
    ('Palestra', 'Palestra attrezzata con macchinari moderni', '06:00 - 22:00', 1),
    ('Piscina', 'Piscina con vista panoramica', '09:00 - 20:00', 2),
    ('Spa', 'Spa con trattamenti benessere e massaggi', '10:00 - 21:00', 3);


