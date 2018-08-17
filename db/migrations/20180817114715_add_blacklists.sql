-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE blacklists(
  id INT PRIMARY KEY, 
  word VARCHAR NOT NULL,
  group_id INT NOT NULL
);


-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE blacklists;