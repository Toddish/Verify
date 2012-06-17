-- Adminer 3.3.4 MySQL dump

SET NAMES utf8;
SET foreign_key_checks = 0;
SET time_zone = 'Europe/London';
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET @adminer_alter = '';

CREATE TABLE IF NOT EXISTS `permission_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_role_permission_id_foreign` (`permission_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER ;;
CREATE PROCEDURE adminer_alter (INOUT alter_command text) BEGIN
	DECLARE _column_name, _collation_name, after varchar(64) DEFAULT '';
	DECLARE _column_type, _column_default text;
	DECLARE _is_nullable char(3);
	DECLARE _extra varchar(30);
	DECLARE _column_comment varchar(255);
	DECLARE done, set_after bool DEFAULT 0;
	DECLARE add_columns text DEFAULT ', ADD `id` int(11) NOT NULL auto_increment FIRST, ADD `permission_id` int(11) NOT NULL AFTER `id`, ADD `role_id` int(11) NOT NULL AFTER `permission_id`, ADD `created_at` datetime NOT NULL AFTER `role_id`, ADD `updated_at` datetime NOT NULL AFTER `created_at`';
	DECLARE columns CURSOR FOR SELECT COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE, COLLATION_NAME, COLUMN_TYPE, EXTRA, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'permission_role' ORDER BY ORDINAL_POSITION;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	SET @alter_table = '';
	OPEN columns;
	REPEAT
		FETCH columns INTO _column_name, _column_default, _is_nullable, _collation_name, _column_type, _extra, _column_comment;
		IF NOT done THEN
			SET set_after = 1;
			CASE _column_name
				WHEN 'id' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `id` int(11) NOT NULL auto_increment FIRST', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = 'auto_increment' AND _column_comment = '' AND after = ''
					, '', ', MODIFY `id` int(11) NOT NULL auto_increment FIRST'));
				WHEN 'permission_id' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `permission_id` int(11) NOT NULL AFTER `id`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = '' AND _column_comment = '' AND after = 'id'
					, '', ', MODIFY `permission_id` int(11) NOT NULL AFTER `id`'));
				WHEN 'role_id' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `role_id` int(11) NOT NULL AFTER `permission_id`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = '' AND _column_comment = '' AND after = 'permission_id'
					, '', ', MODIFY `role_id` int(11) NOT NULL AFTER `permission_id`'));
				WHEN 'created_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `created_at` datetime NOT NULL AFTER `role_id`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'role_id'
					, '', ', MODIFY `created_at` datetime NOT NULL AFTER `role_id`'));
				WHEN 'updated_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `updated_at` datetime NOT NULL AFTER `created_at`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'created_at'
					, '', ', MODIFY `updated_at` datetime NOT NULL AFTER `created_at`'));
				ELSE
					SET @alter_table = CONCAT(@alter_table, ', DROP ', _column_name);
					SET set_after = 0;
			END CASE;
			IF set_after THEN
				SET after = _column_name;
			END IF;
		END IF;
	UNTIL done END REPEAT;
	CLOSE columns;
	IF @alter_table != '' OR add_columns != '' THEN
		SET alter_command = CONCAT(alter_command, 'ALTER TABLE `permission_role`', SUBSTR(CONCAT(add_columns, @alter_table), 2), ';\n');
	END IF;
END;;
DELIMITER ;
CALL adminer_alter(@adminer_alter);
DROP PROCEDURE adminer_alter;


CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER ;;
CREATE PROCEDURE adminer_alter (INOUT alter_command text) BEGIN
	DECLARE _column_name, _collation_name, after varchar(64) DEFAULT '';
	DECLARE _column_type, _column_default text;
	DECLARE _is_nullable char(3);
	DECLARE _extra varchar(30);
	DECLARE _column_comment varchar(255);
	DECLARE done, set_after bool DEFAULT 0;
	DECLARE add_columns text DEFAULT ', ADD `id` int(11) NOT NULL auto_increment FIRST, ADD `name` varchar(100) COLLATE latin1_swedish_ci NOT NULL AFTER `id`, ADD `description` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `name`, ADD `created_at` datetime NOT NULL AFTER `description`, ADD `updated_at` datetime NOT NULL AFTER `created_at`';
	DECLARE columns CURSOR FOR SELECT COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE, COLLATION_NAME, COLUMN_TYPE, EXTRA, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'permissions' ORDER BY ORDINAL_POSITION;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	SET @alter_table = '';
	OPEN columns;
	REPEAT
		FETCH columns INTO _column_name, _column_default, _is_nullable, _collation_name, _column_type, _extra, _column_comment;
		IF NOT done THEN
			SET set_after = 1;
			CASE _column_name
				WHEN 'id' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `id` int(11) NOT NULL auto_increment FIRST', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = 'auto_increment' AND _column_comment = '' AND after = ''
					, '', ', MODIFY `id` int(11) NOT NULL auto_increment FIRST'));
				WHEN 'name' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `name` varchar(100) COLLATE latin1_swedish_ci NOT NULL AFTER `id`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(100)' AND _extra = '' AND _column_comment = '' AND after = 'id'
					, '', ', MODIFY `name` varchar(100) COLLATE latin1_swedish_ci NOT NULL AFTER `id`'));
				WHEN 'description' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `description` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `name`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(255)' AND _extra = '' AND _column_comment = '' AND after = 'name'
					, '', ', MODIFY `description` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `name`'));
				WHEN 'created_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `created_at` datetime NOT NULL AFTER `description`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'description'
					, '', ', MODIFY `created_at` datetime NOT NULL AFTER `description`'));
				WHEN 'updated_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `updated_at` datetime NOT NULL AFTER `created_at`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'created_at'
					, '', ', MODIFY `updated_at` datetime NOT NULL AFTER `created_at`'));
				ELSE
					SET @alter_table = CONCAT(@alter_table, ', DROP ', _column_name);
					SET set_after = 0;
			END CASE;
			IF set_after THEN
				SET after = _column_name;
			END IF;
		END IF;
	UNTIL done END REPEAT;
	CLOSE columns;
	IF @alter_table != '' OR add_columns != '' THEN
		SET alter_command = CONCAT(alter_command, 'ALTER TABLE `permissions`', SUBSTR(CONCAT(add_columns, @alter_table), 2), ';\n');
	END IF;
END;;
DELIMITER ;
CALL adminer_alter(@adminer_alter);
DROP PROCEDURE adminer_alter;


CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `level` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER ;;
CREATE PROCEDURE adminer_alter (INOUT alter_command text) BEGIN
	DECLARE _column_name, _collation_name, after varchar(64) DEFAULT '';
	DECLARE _column_type, _column_default text;
	DECLARE _is_nullable char(3);
	DECLARE _extra varchar(30);
	DECLARE _column_comment varchar(255);
	DECLARE done, set_after bool DEFAULT 0;
	DECLARE add_columns text DEFAULT ', ADD `id` int(11) NOT NULL auto_increment FIRST, ADD `name` varchar(100) COLLATE latin1_swedish_ci NOT NULL AFTER `id`, ADD `description` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `name`, ADD `level` int(11) NOT NULL AFTER `description`, ADD `created_at` datetime NOT NULL AFTER `level`, ADD `updated_at` datetime NOT NULL AFTER `created_at`';
	DECLARE columns CURSOR FOR SELECT COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE, COLLATION_NAME, COLUMN_TYPE, EXTRA, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'roles' ORDER BY ORDINAL_POSITION;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	SET @alter_table = '';
	OPEN columns;
	REPEAT
		FETCH columns INTO _column_name, _column_default, _is_nullable, _collation_name, _column_type, _extra, _column_comment;
		IF NOT done THEN
			SET set_after = 1;
			CASE _column_name
				WHEN 'id' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `id` int(11) NOT NULL auto_increment FIRST', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = 'auto_increment' AND _column_comment = '' AND after = ''
					, '', ', MODIFY `id` int(11) NOT NULL auto_increment FIRST'));
				WHEN 'name' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `name` varchar(100) COLLATE latin1_swedish_ci NOT NULL AFTER `id`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(100)' AND _extra = '' AND _column_comment = '' AND after = 'id'
					, '', ', MODIFY `name` varchar(100) COLLATE latin1_swedish_ci NOT NULL AFTER `id`'));
				WHEN 'description' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `description` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `name`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(255)' AND _extra = '' AND _column_comment = '' AND after = 'name'
					, '', ', MODIFY `description` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `name`'));
				WHEN 'level' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `level` int(11) NOT NULL AFTER `description`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = '' AND _column_comment = '' AND after = 'description'
					, '', ', MODIFY `level` int(11) NOT NULL AFTER `description`'));
				WHEN 'created_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `created_at` datetime NOT NULL AFTER `level`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'level'
					, '', ', MODIFY `created_at` datetime NOT NULL AFTER `level`'));
				WHEN 'updated_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `updated_at` datetime NOT NULL AFTER `created_at`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'created_at'
					, '', ', MODIFY `updated_at` datetime NOT NULL AFTER `created_at`'));
				ELSE
					SET @alter_table = CONCAT(@alter_table, ', DROP ', _column_name);
					SET set_after = 0;
			END CASE;
			IF set_after THEN
				SET after = _column_name;
			END IF;
		END IF;
	UNTIL done END REPEAT;
	CLOSE columns;
	IF @alter_table != '' OR add_columns != '' THEN
		SET alter_command = CONCAT(alter_command, 'ALTER TABLE `roles`', SUBSTR(CONCAT(add_columns, @alter_table), 2), ';\n');
	END IF;
END;;
DELIMITER ;
CALL adminer_alter(@adminer_alter);
DROP PROCEDURE adminer_alter;

INSERT INTO `roles` (`id`, `name`, `description`, `level`, `created_at`, `updated_at`) VALUES
(1,	'Super Admin',	'',	10,	'0000-00-00 00:00:00',	'0000-00-00 00:00:00');

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(60) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  `confirmed` tinyint(4) NOT NULL,
  `disabled` tinyint(4) NOT NULL,
  `deleted` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_username_index` (`username`),
  KEY `users_password_index` (`password`),
  KEY `users_email_index` (`email`),
  KEY `users_role_id_index` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER ;;
CREATE PROCEDURE adminer_alter (INOUT alter_command text) BEGIN
	DECLARE _column_name, _collation_name, after varchar(64) DEFAULT '';
	DECLARE _column_type, _column_default text;
	DECLARE _is_nullable char(3);
	DECLARE _extra varchar(30);
	DECLARE _column_comment varchar(255);
	DECLARE done, set_after bool DEFAULT 0;
	DECLARE add_columns text DEFAULT ', ADD `id` int(11) NOT NULL auto_increment FIRST, ADD `username` varchar(30) COLLATE latin1_swedish_ci NOT NULL AFTER `id`, ADD `password` varchar(60) COLLATE latin1_swedish_ci NOT NULL AFTER `username`, ADD `salt` varchar(32) COLLATE latin1_swedish_ci NOT NULL AFTER `password`, ADD `email` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `salt`, ADD `role_id` int(11) NOT NULL AFTER `email`, ADD `confirmed` tinyint(4) NOT NULL AFTER `role_id`, ADD `disabled` tinyint(4) NOT NULL AFTER `confirmed`, ADD `deleted` tinyint(4) NOT NULL AFTER `disabled`, ADD `created_at` datetime NOT NULL AFTER `deleted`, ADD `updated_at` datetime NOT NULL AFTER `created_at`';
	DECLARE columns CURSOR FOR SELECT COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE, COLLATION_NAME, COLUMN_TYPE, EXTRA, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' ORDER BY ORDINAL_POSITION;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	SET @alter_table = '';
	OPEN columns;
	REPEAT
		FETCH columns INTO _column_name, _column_default, _is_nullable, _collation_name, _column_type, _extra, _column_comment;
		IF NOT done THEN
			SET set_after = 1;
			CASE _column_name
				WHEN 'id' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `id` int(11) NOT NULL auto_increment FIRST', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = 'auto_increment' AND _column_comment = '' AND after = ''
					, '', ', MODIFY `id` int(11) NOT NULL auto_increment FIRST'));
				WHEN 'username' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `username` varchar(30) COLLATE latin1_swedish_ci NOT NULL AFTER `id`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(30)' AND _extra = '' AND _column_comment = '' AND after = 'id'
					, '', ', MODIFY `username` varchar(30) COLLATE latin1_swedish_ci NOT NULL AFTER `id`'));
				WHEN 'password' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `password` varchar(60) COLLATE latin1_swedish_ci NOT NULL AFTER `username`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(60)' AND _extra = '' AND _column_comment = '' AND after = 'username'
					, '', ', MODIFY `password` varchar(60) COLLATE latin1_swedish_ci NOT NULL AFTER `username`'));
				WHEN 'salt' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `salt` varchar(32) COLLATE latin1_swedish_ci NOT NULL AFTER `password`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(32)' AND _extra = '' AND _column_comment = '' AND after = 'password'
					, '', ', MODIFY `salt` varchar(32) COLLATE latin1_swedish_ci NOT NULL AFTER `password`'));
				WHEN 'email' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `email` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `salt`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> 'latin1_swedish_ci' AND _column_type = 'varchar(255)' AND _extra = '' AND _column_comment = '' AND after = 'salt'
					, '', ', MODIFY `email` varchar(255) COLLATE latin1_swedish_ci NOT NULL AFTER `salt`'));
				WHEN 'role_id' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `role_id` int(11) NOT NULL AFTER `email`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'int(11)' AND _extra = '' AND _column_comment = '' AND after = 'email'
					, '', ', MODIFY `role_id` int(11) NOT NULL AFTER `email`'));
				WHEN 'confirmed' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `confirmed` tinyint(4) NOT NULL AFTER `role_id`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'tinyint(4)' AND _extra = '' AND _column_comment = '' AND after = 'role_id'
					, '', ', MODIFY `confirmed` tinyint(4) NOT NULL AFTER `role_id`'));
				WHEN 'disabled' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `disabled` tinyint(4) NOT NULL AFTER `confirmed`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'tinyint(4)' AND _extra = '' AND _column_comment = '' AND after = 'confirmed'
					, '', ', MODIFY `disabled` tinyint(4) NOT NULL AFTER `confirmed`'));
				WHEN 'deleted' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `deleted` tinyint(4) NOT NULL AFTER `disabled`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'tinyint(4)' AND _extra = '' AND _column_comment = '' AND after = 'disabled'
					, '', ', MODIFY `deleted` tinyint(4) NOT NULL AFTER `disabled`'));
				WHEN 'created_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `created_at` datetime NOT NULL AFTER `deleted`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'deleted'
					, '', ', MODIFY `created_at` datetime NOT NULL AFTER `deleted`'));
				WHEN 'updated_at' THEN
					SET add_columns = REPLACE(add_columns, ', ADD `updated_at` datetime NOT NULL AFTER `created_at`', IF(
						_column_default <=> NULL AND _is_nullable = 'NO' AND _collation_name <=> NULL AND _column_type = 'datetime' AND _extra = '' AND _column_comment = '' AND after = 'created_at'
					, '', ', MODIFY `updated_at` datetime NOT NULL AFTER `created_at`'));
				ELSE
					SET @alter_table = CONCAT(@alter_table, ', DROP ', _column_name);
					SET set_after = 0;
			END CASE;
			IF set_after THEN
				SET after = _column_name;
			END IF;
		END IF;
	UNTIL done END REPEAT;
	CLOSE columns;
	IF @alter_table != '' OR add_columns != '' THEN
		SET alter_command = CONCAT(alter_command, 'ALTER TABLE `users`', SUBSTR(CONCAT(add_columns, @alter_table), 2), ';\n');
	END IF;
END;;
DELIMITER ;
CALL adminer_alter(@adminer_alter);
DROP PROCEDURE adminer_alter;

INSERT INTO `users` (`id`, `username`, `password`, `salt`, `email`, `role_id`, `confirmed`, `disabled`, `deleted`, `created_at`, `updated_at`) VALUES
(1,	'admin',	'$2a$08$rqN6idpy0FwezH72fQcdqunbJp7GJVm8j94atsTOqCeuNvc3PzH3m',	'a227383075861e775d0af6281ea05a49',	'example@gmail.com',	1,	0,	0,	0,	'2012-06-17 21:59:01',	'0000-00-00 00:00:00');

SELECT @adminer_alter;
-- 2012-06-17 23:27:54
