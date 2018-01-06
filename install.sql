UPDATE `{#}perms_rules` SET `type` = 'list', `options` = 'premod,yes' WHERE `controller` = 'groups' AND `name` = 'add';
UPDATE `{#}perms_users` SET `value`= 'yes' WHERE `rule_id` = (SELECT `id` FROM `{#}perms_rules` WHERE `controller` = 'groups' AND `name` = 'add');
UPDATE `{#}perms_rules` SET `type` = 'list', `options` = 'premod,yes' WHERE `controller` = 'content' AND `name` = 'add';
UPDATE `{#}perms_users` SET `value`= 'yes' WHERE `rule_id` = (SELECT `id` FROM `{#}perms_rules` WHERE `controller` = 'content' AND `name` = 'add');
UPDATE `{#}perms_rules` SET `type` = 'list', `options` = 'premod_own,own,premod_all,all' WHERE `controller` = 'content' AND `name` = 'edit';
ALTER TABLE `{#}content_datasets` CHANGE `filters` `filters` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Масив фільтрів набору';
ALTER TABLE `{#}content_datasets` CHANGE `sorting` `sorting` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Масив правил сортування';
DROP TABLE IF EXISTS `{#}jobs`;
CREATE TABLE `{#}jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(100) DEFAULT NULL COMMENT 'Назва черги',
  `payload` text COMMENT 'Дані задачі',
  `last_error` varchar(200) DEFAULT NULL COMMENT 'Остання помилка',
  `priority` tinyint(1) UNSIGNED DEFAULT '1' COMMENT 'Пріоритет',
  `attempts` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Спроби виконання',
  `is_locked` tinyint(1) UNSIGNED DEFAULT NULL COMMENT 'Блокування одночасного запуску',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата постановки в чергу',
  `date_started` timestamp NULL DEFAULT NULL COMMENT 'Дата останньої спроби виконання завдання',
  PRIMARY KEY (`id`),
  KEY `queue` (`queue`),
  KEY `attempts` (`attempts`,`is_locked`,`date_started`,`priority`,`date_created`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Черга';
DELETE FROM `{#}perms_rules` WHERE `controller` = 'comments' AND `name` = 'is_moderator';
