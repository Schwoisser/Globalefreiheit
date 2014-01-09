CREATE TABLE Artikel_Rubrik
(
ArtikelId int NOT NULL,
RubrikId int NOT NULL,

FOREIGN KEY (ArtikelId) REFERENCES Artikel(Id),
FOREIGN KEY (RubrikId) REFERENCES Rubrik(RubrikId)
)