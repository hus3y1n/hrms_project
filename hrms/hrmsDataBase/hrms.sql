CREATE TABLE public.users(
	id INT GENERATED BY DEFAULT AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
	email CHARACTER VARYING(320) NOT NULL,
	password CHARACTER VARYING(25) NOT NULL,
	CONSTRAINT pk_users PRIMARY KEY(id),
	CONSTRAINT uc_users_email UNIQUE(email)
);

CREATE TABLE public.employee(
	id INT NOT NULL,
	first_name CHARACTER VARYING(35) NOT NULL,
	last_name CHARACTER VARYING(35) NOT NULL,
	CONSTRAINT pk_employees PRIMARY KEY(id),
	CONSTRAINT fk_employees_users FOREIGN KEY(id) REFERENCES public.users(id)
);

CREATE TABLE public.candidates(
	id INT NOT NULL,
	first_name CHARACTER VARYING(35) NOT NULL,
	last_name CHARACTER VARYING(35) NOT NULL,
	identity_number CHARACTER VARYING(11) NOT NULL,
	birth_year INT NOT NULL,
	CONSTRAINT pk_candidates PRIMARY KEY(id),
	CONSTRAINT fk_candidates_users FOREIGN KEY(id) REFERENCES public.users(id),
	CONSTRAINT uc_candidates_identity_number UNIQUE(identity_number)
);

CREATE TABLE public.employers(
	id INT NOT NULL,
	company_name CHARACTER VARYING(255) NOT NULL,
	web_address CHARACTER VARYING(50) NOT NULL,
	phone_number CHARACTER VARYING(12) NOT NULL,
	CONSTRAINT pk_employers PRIMARY KEY(id),
	CONSTRAINT fk_emloyers_users FOREIGN KEY(id) REFERENCES public.users(id)
);

CREATE TABLE public.verification_codes(
	id INT NOT NULL,
	code CHARACTER VARYING(38) NOT NULL,
	is_verified BOOLEAN NOT NULL,
	verifed_date DATE,
	CONSTRAINT pk_verification_codes PRIMARY KEY(id),
	CONSTRAINT uc_verification_codes_code UNIQUE(code)
);

CREATE TABLE public.verification_codes_candidates(
	id INT NOT NULL,
	candidate_id INT NOT NULL,
	CONSTRAINT pk_verification_codes_candidaties PRIMARY KEY(id),
	CONSTRAINT fk_verification_code_candidates_verification_codes
	FOREIGN KEY(id) REFERENCES public.verification_codes(id),
	CONSTRAINT fk_verification_code_candidates_candidates
	FOREIGN KEY(id) REFERENCES public.candidates(id)
);

CREATE TABLE public.verification_code_employers(
	id INT NOT NULL,
	employers_id INT NOT NULL,
	CONSTRAINT pk_verification_codes_employers PRIMARY KEY(id),
	CONSTRAINT fk_verification_code_employers_verification_codes
	FOREIGN KEY(id) REFERENCES public.verification_codes(id),
	CONSTRAINT fk_verification_code_employers_employers
	FOREIGN KEY(employers_id) REFERENCES public.employers(id)
);

CREATE TABLE public.employee_confirm(
	id INT GENERATED BY DEFAULT AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
	employee_id INT NOT NULL,
	is_confirmed BOOLEAN NOT NULL,
	confirm_date DATE,
	CONSTRAINT pk_employee_confirms PRIMARY KEY(id),
	CONSTRAINT fk_employee_confirm_employee_id FOREIGN KEY(employee_id) REFERENCES public.employee(id)
);

CREATE TABLE public.employee_confirm_employers(
	id INT NOT NULL,
	employer_id INT NOT NULL,
	CONSTRAINT pk_employee_confirm_employers PRIMARY KEY(id),
	CONSTRAINT fk_employee_confirm_employers_employee_confirm
	FOREIGN KEY(id) REFERENCES public.employee_confirm(id),
	CONSTRAINT fk_employee_confirm_employers_employers
	FOREIGN KEY(employer_id) REFERENCES public.employers(id)

);

CREATE TABLE public.job_title(
	id INT GENERATED BY DEFAULT AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
	title CHARACTER VARYING(255),
	CONSTRAINT pk_job_title PRIMARY KEY(id),
	CONSTRAINT uc_job_titles_title UNIQUE(title)
);

INSERT INTO users VALUES(1, 'hozlu1592@gmail.com', '123456');
INSERT INTO users VALUES(2, 'mth_1592@gmail.com', '123456');
INSERT INTO users VALUES(3, 'ali_1592@gmail.com', '123456');
INSERT INTO users VALUES(4, 'batu_1592@gmail.com', '123456');
INSERT INTO users VALUES(5, 'hzek_1592@gmail.com', '123456');

INSERT INTO employee VALUES(1, 'Huseyin', 'Ozlu');

INSERT INTO candidates VALUES(1, 'Huseyin', 'Ozlu', 11111111111, 2002);
INSERT INTO candidates VALUES(2, 'Metehan', 'reis', 22222222222, 2000);
INSERT INTO candidates VALUES(3, 'Ali', 'Yas', 33333333333, 1657);
INSERT INTO candidates VALUES(4, 'Batu', 'Oz', 44444444444, 245);
INSERT INTO candidates VALUES(5, 'Halil', 'Zeki', 99999999999, 35266);

INSERT INTO job_title VALUES(1, 'Software_Devoloper');
INSERT INTO job_title VALUES(2, 'Software_architect');

INSERT INTO employers VALUES(1, 'CompanySample', 'companysample.com', 05777777777);
INSERT INTO employers VALUES(2, 'CompanySample2', 'companysample2.com', 05333333333);
