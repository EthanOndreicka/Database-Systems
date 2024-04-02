CREATE TABLE People (
    people_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    birth_date DATE,
    spouse_name VARCHAR(100)
);

CREATE TABLE Actors (
    actor_id SERIAL PRIMARY KEY,
    people_id INTEGER REFERENCES People(people_id),
    hair_color VARCHAR(50),
    eye_color VARCHAR(50),
    height_inches INTEGER,
    weight FLOAT,
    favorite_color VARCHAR(50),
    screen_actors_guild_anniversary DATE
);

CREATE TABLE Directors (
    director_id SERIAL PRIMARY KEY,
    people_id INTEGER REFERENCES People(people_id),
    film_school_attended VARCHAR(100),
    directors_guild_anniversary DATE,
    favorite_lens_maker VARCHAR(100)
);

CREATE TABLE Movies (
    movie_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    year_released INTEGER,
    mpaa_number VARCHAR(10),
    domestic_box_office_sales INTEGER,
    foreign_box_office_sales INTEGER,
    dvd_bluray_sales INTEGER,
    director_id INTEGER REFERENCES Directors(director_id),
    actor_id INTEGER REFERENCES Actors(actor_id)
);
