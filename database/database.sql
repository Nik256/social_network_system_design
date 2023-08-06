CREATE TYPE "chat_type" AS ENUM (
  'private',
  'group'
);

CREATE TYPE "media_type" AS ENUM (
  'photo',
  'video',
  'audio'
);

CREATE TYPE "realtion_types" AS ENUM (
  'friend',
  'subscriber',
  'love'
);

-- Relational
-- Replication: master-slave (sync, async)
CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "description" varchar,
  "city" varchar,
  "photo" varchar
);

CREATE TABLE "users_interests" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "name" varchar,
  "description" varchar
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "body" text,
  "user_id" integer,
  "status" varchar
);

CREATE TABLE "posts_hashtags" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "name" varchar
);

CREATE TABLE "posts_media" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "type" media_type,
  "url" varchar
);

CREATE TABLE "posts_comments" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "text" text
);

-- Key-value
-- Replication: master-slave (sync, async)
CREATE TABLE "messages" (
  "id" integer PRIMARY KEY,
  "sender_id" integer,
  "text" text,
  "read" boolean
);

CREATE TABLE "chats" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "type" chat_type
);

CREATE TABLE "chats_messages" (
  "chat_id" integer,
  "message_id" integer,
  PRIMARY KEY ("chat_id", "message_id")
);

-- Key-value
-- Replication: master-slave (async)
CREATE TABLE "likes" (
  "post_id" integer PRIMARY KEY,
  "count" integer
);

CREATE TABLE "views" (
  "post_id" integer PRIMARY KEY,
  "count" integer
);

-- Graph
-- Replication: master-slave (async)
CREATE TABLE "users_realations" (
  "user_id" integer PRIMARY KEY,
  "realated_user_id" integer,
  "realtion_type" realtion_types
);

ALTER TABLE "users_interests" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "posts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "posts_hashtags" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id");

ALTER TABLE "posts_media" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id");

ALTER TABLE "posts_comments" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id");

ALTER TABLE "posts_comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "chats_messages" ADD FOREIGN KEY ("chat_id") REFERENCES "messages" ("id");

ALTER TABLE "chats_messages" ADD FOREIGN KEY ("message_id") REFERENCES "chats" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("sender_id") REFERENCES "users" ("id");
