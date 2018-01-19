DROP DATABASE IF EXISTS kiddio;
CREATE DATABASE kiddio;

\c kiddio;

CREATE EXTENSION postgis;


CREATE TABLE images (
  image_id SERIAL PRIMARY KEY,
  image_path VARCHAR (100) UNIQUE NOT NULL
);

CREATE TABLE region (
  region_id SERIAL PRIMARY KEY,
  region_name VARCHAR (100) NOT NULL
);

CREATE TABLE display_group (
  display_group_id SERIAL PRIMARY KEY,
  display_group_name VARCHAR (100) NOT NULL,
  display_group_image_id INT NOT NULL REFERENCES images
);

CREATE TABLE configuration (
  image_directory VARCHAR (100) NOT NULL,
  activity_HTML_header VARCHAR (2048) NOT NULL,
  activity_HTML_footer VARCHAR (2048) NOT NULL,
  phone_image_id SERIAL NOT NULL REFERENCES images,
  email_image_id SERIAL NOT NULL REFERENCES images,
  video_image_id SERIAL NOT NULL REFERENCES images,
  map_image_id SERIAL NOT NULL REFERENCES images,
  weaather_image_id SERIAL NOT NULL REFERENCES images
);

CREATE TABLE adverts (
  advert_id SERIAL PRIMARY KEY,
  advert_image_id SERIAL NOT NULL REFERENCES images,
  advert_image_alt_text VARCHAR (200) NOT NULL,
  advert_website_url VARCHAR (200) NOT NULL,
  advert_phone VARCHAR (20) NOT NULL,
  advert_email VARCHAR (50) NOT NULL,
  advert_location GEOMETRY NOT NULL,
  advert_video_url VARCHAR (200) NOT NULL
);

CREATE TABLE vendor (
  vendor_id SERIAL PRIMARY KEY,
  vendor_name VARCHAR (255) NOT NULL,
  vendor_address_line1 VARCHAR (255) NOT NULL,
  vendor_address_line2 VARCHAR (255) NOT NULL,
  vendor_city VARCHAR (255) NOT NULL,
  vendor_state_code VARCHAR (2) NOT NULL,
  vendor_zipcode VARCHAR (10) NOT NULL,
  vendor_country VARCHAR (25) NOT NULL,
  vendor_contact_person VARCHAR (50) NOT NULL,
  vendor_contact_phone_number VARCHAR (25) NOT NULL,
  vendor_email_address VARCHAR (100) NOT NULL,
  bendor_date_added DATE NOT NULL,
  vendor_credit_card_number VARCHAR (25) NOT NULL,
  vendor_credit_card_expiry_date_mmyy CHAR (4) NOT NULL,
  vendor_credit_card_cvv VARCHAR (5) NOT NULL
);


CREATE TABLE menu_advert_placement (
  menu_type CHAR (1) NOT NULL,
  region_id SERIAL NOT NULL REFERENCES region,
  advert_id INT NOT NULL REFERENCES adverts,
  display_position SMALLINT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  cost_type_fixed_or_per_click CHAR (1) NOT NULL,
  cost_per_action MONEY NOT NULL,
  cost_ceiling INT NOT NULL,
  added_by_vendor_id SERIAL NOT NULL REFERENCES vendor,
  date_added DATE NOT NULL
);

CREATE TABLE display_group_advert_placement (
  region_id SMALLINT NOT NULL REFERENCES region,
  display_group_id SERIAL NOT NULL REFERENCES display_group,
  advert_id SERIAL NOT NULL REFERENCES adverts,
  display_position SMALLINT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  cost_type_fixed_or_per_click CHAR (1) NOT NULL,
  cost_per_action MONEY NOT NULL,
  cost_ceiling INT NOT NULL,
  added_by_vendor_id SERIAL NOT NULL REFERENCES vendor,
  date_added DATE NOT NULL
);

CREATE TABLE kid_interest_category (
  kid_interest_category_id SERIAL PRIMARY KEY,
  category_description VARCHAR (255) NOT NULL
);

CREATE TABLE activity (
  activity_id SERIAL PRIMARY KEY,
  activity_title VARCHAR (200) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  menu_title VARCHAR (200) NOT NULL,
  cost_in_text VARCHAR (200) NOT NULL,
  cost_in_numberic_value INT NOT NULL,
  ages VARCHAR (200) NOT NULL,
  min_age SMALLINT NOT NULL,
  max_age SMALLINT NOT NULL,
  location VARCHAR (200) NOT NULL,
  contact_phone VARCHAR (20) NOT NULL,
  contact_website VARCHAR (200) NOT NULL,
  contact_website_alt_text VARCHAR (200) NOT NULL,
  image1_id SERIAL NOT NULL REFERENCES images,
  image1_alt_text VARCHAR (1000) NOT NULL,
  text1 VARCHAR (100) NOT NULL,
  image2_id INT,
  image2_alt_text VARCHAR (100),
  text2 VARCHAR (1000),
  image3_id INT,
  image3_alt_text VARCHAR (100),
  text3 VARCHAR (1000),  
  video_text VARCHAR (200),
  videoURL VARCHAR (200),
  video_alt_text VARCHAR (200),
  email_address VARCHAR (200) NOT NULL
);

CREATE TABLE activity_placement (
  position_id SERIAL PRIMARY KEY,
  region_id SERIAL NOT NULL REFERENCES region,
  display_group_id SERIAL NOT NULL REFERENCES display_group,
  activity_id SERIAL NOT NULL REFERENCES activity
);

CREATE TABLE customer (
  costumer_id SERIAL PRIMARY KEY,
  customer_email_address VARCHAR (255) UNIQUE NOT NULL,
  custumer_first_name VARCHAR (20) NOT NULL,
  customer_last_name VARCHAR (20) NOT NULL,
  customer_join_date DATE NOT NULL,
  region_id SERIAL NOT NULL REFERENCES region
);

CREATE TABLE invited_customer (
  costumer_id SERIAL REFERENCES customer,
  invited_customer_email_address VARCHAR (255) UNIQUE NOT NULL,
  customer_invite_date DATE NOT NULL
);


CREATE TABLE customer_kid (
  kid_id SERIAL PRIMARY KEY,
  kid_age SMALLINT NOT NULL,
  customer_number SERIAL NOT NULL REFERENCES customer
);

CREATE TABLE customer_kid_interest_category (
  customer_id SERIAL NOT NULL REFERENCES customer,
  kid_id SERIAL NOT NULL REFERENCES customer_kid,
  kid_interest_category SERIAL NOT NULL REFERENCES kid_interest_category
);


CREATE TABLE customer_activity_comments (
  activity_id SERIAL NOT NULL REFERENCES activity,
  customer_id SERIAL NOT NULL REFERENCES customer,
  comment_date DATE NOT NULL,
  comment_score SMALLINT NOT NULL,
  comment_text VARCHAR (1000) NOT NULL
);
