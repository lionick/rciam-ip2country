-- Statistics for country logins including idp and sp
CREATE TABLE IF NOT EXISTS statistics_country (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    sourceidp character varying(255) NOT NULL,
    service character varying(255) NOT NULL,
    countrycode character varying(2) NOT NULL,
	  country character varying(255) NOT NULL,
    count int NOT NULL
);

CREATE INDEX IF NOT EXISTS statistics_country_i1 ON statistics_country (date);
CREATE INDEX IF NOT EXISTS statistics_country_i2 ON statistics_country (sourceidp);
CREATE INDEX IF NOT EXISTS statistics_country_i3 ON statistics_country (service);
CREATE INDEX IF NOT EXISTS statistics_country_i4 ON statistics_country (countrycode);
CREATE INDEX IF NOT EXISTS statistics_country_i5 ON statistics_country (country);
CREATE UNIQUE INDEX IF NOT EXISTS idx_statistics_country 
ON statistics_country(date, sourceidp, service, countrycode);

-- Statistics for country logins including userid
CREATE TABLE IF NOT EXISTS statistics_user_country (
id SERIAL PRIMARY KEY,
date DATE NOT NULL,
userid character varying(255) NOT NULL,
countrycode character varying(2) NOT NULL,
country character varying(255) NOT NULL,
count int NOT NULL
);

CREATE INDEX IF NOT EXISTS statistics_user_country_i1 ON statistics_user_country (date);
CREATE INDEX IF NOT EXISTS statistics_user_country_i2 ON statistics_user_country (userid);
CREATE INDEX IF NOT EXISTS statistics_user_country_i3 ON statistics_user_country (countrycode);
CREATE INDEX IF NOT EXISTS statistics_user_country_i4 ON statistics_user_country (country);
CREATE UNIQUE INDEX IF NOT EXISTS idx_statistics_user_country ON statistics_user_country(date, userid, countrycode);

