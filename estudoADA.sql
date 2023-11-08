/*
DROP TABLE IF EXISTS Matricula;
DROP TABLE IF EXISTS Aluno;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Disciplina;
DROP TABLE IF EXISTS Livros;
DROP TABLE IF EXISTS Turma;
*/

--Criando as tabelas:

CREATE TABLE IF NOT EXISTS Turma(
	id_turma 	integer 	NOT NULL,
	num_alunos 	smallint	NOT NULL,
	tipo_curso 	varchar(20)	NOT NULL,
	CONSTRAINT "Turma_pkey" PRIMARY KEY (id_turma)
);

CREATE TABLE IF NOT EXISTS Livros(
	id_livro 	integer 	 NOT NULL,
	nome 		varchar(30)	 NOT NULL,
	autor 		varchar(40)	 NOT NULL,
	sinopse 	varchar(500) NOT NULL,
	CONSTRAINT "Livros_pkey" PRIMARY KEY (id_livro)
);

CREATE TABLE IF NOT EXISTS Disciplina(
	id_disciplina 	integer 	 NOT NULL,
	nome 			varchar(20)	 NOT NULL,
	ementa 			text		 NOT NULL,
	id_livro 		integer		 NOT NULL,
	CONSTRAINT "Disciplina_pkey" PRIMARY KEY (id_disciplina),
	FOREIGN KEY (id_livro)
	REFERENCES Livros(id_livro)
);

CREATE TABLE IF NOT EXISTS Professor(
	id_professor 	integer 	NOT NULL,
	nome 			varchar(40)	NOT NULL,
	celular 		varchar(14)	NOT NULL,
	id_disciplina 	integer		NOT NULL,
	CONSTRAINT "Professor_pkey" PRIMARY KEY (id_professor),
	FOREIGN KEY (id_disciplina)
	REFERENCES Disciplina(id_disciplina)
);

CREATE TABLE IF NOT EXISTS Aluno(
	id_aluno 	integer 	NOT NULL,
	id_turma 	integer 	NOT NULL,
	celular 	varchar(14),
	idade 		smallint,
	nome 		varchar(40)	NOT NULL,
	CONSTRAINT "Aluno_pkey" PRIMARY KEY (id_aluno),
	FOREIGN KEY (id_turma)
	REFERENCES Turma(id_turma)
);

CREATE TABLE IF NOT EXISTS Matricula(
    id_matricula 	integer 	NOT NULL,
    validade 		date 		NOT NULL,
    preco 			real 		NOT NULL,
	id_aluno 		integer		NOT NULL,
    CONSTRAINT "Matricula_pkey" PRIMARY KEY (id_matricula),
	FOREIGN KEY (id_aluno)
	REFERENCES Aluno(id_aluno)
);


--Alimentando as tabelas:

INSERT INTO Livros VALUES
(1, 'Matematica Aplicada', 'Joao Jose', 'Tudo sobre matematica...'),
(2, 'Portugues para Brasileiros', 'Maria Cabral', 'Aprendam o idioma...'),
(3, 'Ciencias sociais', 'Maria Joana', 'Um livro muito bem bolado');

INSERT INTO Turma VALUES
(1, 35, 'Presencial'),
(2, 120, 'EAD');

INSERT INTO Disciplina VALUES
(1, 'Portugues', 'Gramatica local', 2),
(2, 'Matematica', 'Muitas continhas', 1),
(3, 'Sociologia', 'Estudo da sociedade', 3);

INSERT INTO Professor VALUES
(1, 'Afranio Guimaraes', '1198745-2312', 3),
(2, 'Agripina Rodrigues', '1195874-1236', 2),
(3, 'Eustaquia de Sa', '1197458-6541', 1);

INSERT INTO Aluno VALUES
(1, 1, '1193698-4587', 18, 'Frederico Miranda'),
(2, 2, '1196547-8965', 15, 'Alberta Mendonca'),
(3, 2, null, 23, 'Gumercindo Ipiranga');

INSERT INTO Matricula VALUES
(1, '30/12/2023', 900, 1),
(2, '19/12/2024', 100, 2),
(3, '28/11/2023', 750, 3);


--Edicao e remocao de dados:

UPDATE Aluno
	SET nome = 'Josefa Hernanes' 
	WHERE id_aluno = 1;
	
DELETE FROM Matricula
	WHERE id_aluno = 2;
DELETE FROM Aluno
	WHERE id_aluno = 2;

--Criando uma View de consulta restritiva simples:

CREATE VIEW matricula_consulta_prazo AS (
	SELECT 
		id_matricula,
		id_aluno,
		validade
	FROM Matricula
);

--Executando a VIEW:

SELECT * FROM matricula_consulta_prazo;