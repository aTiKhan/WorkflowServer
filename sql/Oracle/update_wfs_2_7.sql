/*
Company: OptimaJet
Project: WorkflowServer Provider for Oracle
Version: 2.7
File: update_wfs_2_7.sql
*/

CREATE TABLE WORKFLOWSERVERUSER(
	ID RAW(16),
	NAME NVARCHAR2(256) NOT NULL,
	EMAIL NVARCHAR2(256) NULL,
        PHONE NVARCHAR2(256) NULL,
	ISLOCKED CHAR(1 BYTE) DEFAULT 0 NOT NULL,
	EXTERNALID NVARCHAR2(1024) NULL,
  LOCKFLAG RAW(16) NOT NULL,
	TENANTID NVARCHAR2(1024) NULL,
	ROLES NCLOB NULL,
	EXTENSIONS NCLOB NULL,
    CONSTRAINT PK_WORKFLOWSERVERUSER PRIMARY KEY (ID) USING INDEX STORAGE ( INITIAL 64K NEXT 1M MAXEXTENTS UNLIMITED ))
LOGGING;

CREATE TABLE WORKFLOWSERVERUSERCREDENTIAL(
	ID RAW(16),
	PASSWORDHASH NVARCHAR2(128) NULL,
	PASSWORDSALT NVARCHAR2(128) NULL,
	USERID RAW(16) NOT NULL,
	LOGIN NVARCHAR2(256) NOT NULL,
	AUTHTYPE NUMBER(3) NOT NULL,
  TENANTID NVARCHAR2(1024) NULL,
  EXTERNALPROVIDERNAME NVARCHAR2(128) NULL,
    CONSTRAINT FK_WORKFLOWSERVERUSER_WORKFLOWSERVERUSERCREDENTIAL FOREIGN KEY (USERID)
        REFERENCES WORKFLOWSERVERUSER(ID) ON DELETE CASCADE,
    CONSTRAINT PK_WORKFLOWSERVERUSERCREDENTIAL PRIMARY KEY (ID) USING INDEX STORAGE ( INITIAL 64K NEXT 1M MAXEXTENTS UNLIMITED ))
LOGGING;

CREATE INDEX IX_WORKFLOWSERVERUSERCREDENTIAL_USERID ON WORKFLOWSERVERUSERCREDENTIAL (USERID);
CREATE INDEX IX_WORKFLOWSERVERUSERCREDENTIAL_LOGIN ON WORKFLOWSERVERUSERCREDENTIAL (LOGIN);

ALTER TABLE WORKFLOWPROCESSINSTANCE ADD
(
	SUBPROCESSNAME CLOB NULL
);

UPDATE WORKFLOWPROCESSINSTANCE SET SUBPROCESSNAME = STARTINGTRANSITION;

COMMIT;