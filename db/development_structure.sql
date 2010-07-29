CREATE TABLE "games" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "war" integer DEFAULT 1, "round" integer DEFAULT 1, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "playings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "game_id" integer, "country" varchar(255), "play_order" integer, "pass" boolean DEFAULT 'f', "created_at" datetime, "updated_at" datetime);
CREATE TABLE "propositions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "game_id" integer, "war" integer, "round" integer, "positionA" varchar(255), "positionB" varchar(255), "amount" integer, "opened" boolean, "rejected" boolean, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "password_salt" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "remember_token" varchar(255), "remember_created_at" datetime, "authentication_token" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20100618050109');

INSERT INTO schema_migrations (version) VALUES ('20100621124529');

INSERT INTO schema_migrations (version) VALUES ('20100618125753');

INSERT INTO schema_migrations (version) VALUES ('20100618050221');