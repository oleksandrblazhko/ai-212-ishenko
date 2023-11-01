CREATE TABLE users(
	id INT PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	email VARCHAR(255) NOT NULL CHECK (email ~ '^([a-z0-9][a-z0-9._-]*@[a-z][a-z0-9._-]*\.[a-z]{2,4})$'),
	password VARCHAR(20) NOT NULL
);

CREATE TABLE info_topics(
	id INT PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE ligth_info(
	id INT PRIMARY KEY,
	description VARCHAR(250) NOT null,
	info_type VARCHAR(15) NOT null,
	info BYTEA NOT null,
	topics_id INT REFERENCES info_topics(id)
);

CREATE TABLE parameters(
	id INT PRIMARY KEY,
	type VARCHAR(50),
	count_lamp INT NOT NULL CHECK (count_lamp > 0),
	plan BYTEA,
	level INT CHECK (level > 0),
	intense DECIMAL(10, 2) CHECK (intense > 0),
	brightness DECIMAL(10, 2) CHECK (brightness > 0)
);

CREATE TABLE tamplate_light_plan(
	id INT PRIMARY KEY,
	name VARCHAR(100) NOT null,
	description VARCHAR(1000) NOT null,
	needs VARCHAR(2000) NOT null,
	work_plan VARCHAR(2000) NOT null,
	param_id INT REFERENCES parameters(id)
);

CREATE TABLE light_plan(
	id INT PRIMARY KEY,
	name VARCHAR(100) NOT null,
	needs VARCHAR(2000) NOT null,
	work_plan VARCHAR(2000) NOT null,
	param_id INT REFERENCES parameters(id),
	user_id INT REFERENCES users(id),
	tamplate_id INT REFERENCES tamplate_light_plan(id)
);

CREATE TABLE plan_info(
	id INT PRIMARY KEY,
	plan_id INT REFERENCES light_plan(id),
	info_id INT REFERENCES ligth_info(id)
);
