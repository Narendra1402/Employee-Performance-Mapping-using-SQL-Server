CREATE TABLE dbo.datascienceteam_new (
    EMP_ID       NVARCHAR(20) PRIMARY KEY,
    FIRST_NAME   NVARCHAR(10),
    LAST_NAME    NVARCHAR(10),
    GENDER       NVARCHAR(10),
    ROLE         NVARCHAR(30),
    DEPT         NVARCHAR(20),
    EXP          INT,
    COUNTRY      NVARCHAR(10),
    CONTINENT    NVARCHAR(20)
);

INSERT INTO dbo.datascienceteam_new (
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    GENDER,
    ROLE,
    DEPT,
    EXP,
    COUNTRY,
    CONTINENT
)
SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    GENDER,
    ROLE,
    DEPT,
    EXP,
    COUNTRY,
    CONTINENT
FROM dbo.datascienceteam;


INSERT INTO dbo.datascienceteam_new
SELECT * FROM dbo.datascienceteam;


SELECT*
FROM datascienceteam_new


CREATE TABLE dbo.employeeRecord_new (
    EMP_ID        NVARCHAR(20) PRIMARY KEY,
    FIRST_NAME    NVARCHAR(10),
    LAST_NAME     NVARCHAR(10),
    GENDER        NVARCHAR(10),
    ROLE          NVARCHAR(100),
    DEPT          NVARCHAR(100),
    EXP           INT,
    COUNTRY       NVARCHAR(30),
    CONTINENT     NVARCHAR(30),
    SALARY        DECIMAL(18, 2),
    EMP_RATING    FLOAT,
    MANAGER_ID    NVARCHAR(20),
    PROJ_ID       NVARCHAR(20)
);

INSERT INTO dbo.projectTable_new
SELECT * FROM dbo.projectTable;


EXEC sp_rename 'dbo.employeeRecord_new', 'employeeRecord';
EXEC sp_rename 'dbo.datascienceteam_new', 'datascienceteam';
EXEC sp_rename 'dbo.projectTable_new', 'projectTable';