-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  username VARCHAR NOT NULL,
  user_id INTEGER NOT NULL,
  chat_id VARCHAR NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE users;