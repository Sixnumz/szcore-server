CREATE TABLE `user_quests` (
  `identifier` VARCHAR(50) NOT NULL,
  `quest` VARCHAR(50) NOT NULL,
  `completed` BOOLEAN NOT NULL DEFAULT 0,
  `last_reset` DATETIME NOT NULL,
  PRIMARY KEY (`identifier`)
);
