BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "artist" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "collection" (
	"id"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "inspiration" (
	"is"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT NOT NULL,
	"description"	TEXT,
	"image_count"	INTEGER DEFAULT 0,
	"links"	TEXT,
	"inspiration_group_id"	INTEGER,
	PRIMARY KEY("is" AUTOINCREMENT),
	FOREIGN KEY("inspiration_group_id") REFERENCES "inspiration_group"("id")
);
CREATE TABLE IF NOT EXISTS "inspiration_group" (
	"id"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "wallpaper" (
	"id"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT UNIQUE,
	"width"	INTEGER NOT NULL,
	"height"	INTEGER NOT NULL,
	"year"	INTEGER,
	"month"	INTEGER,
	"collection_id"	INTEGER,
	"inspiration_id"	INTEGER,
	"artist_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("collection_id") REFERENCES "collection"("id"),
	FOREIGN KEY("inspiration_id") REFERENCES "inspiration"("is"),
	FOREIGN KEY("artist_id") REFERENCES "artist"("id")
);
INSERT INTO "artist" VALUES (1,'Yasan Glass');
INSERT INTO "collection" VALUES (1,'AMOLED mnml');
INSERT INTO "collection" VALUES (2,'mnml');
INSERT INTO "inspiration" VALUES (1,'Sunset at sea',NULL,0,NULL,NULL);
INSERT INTO "inspiration" VALUES (2,'Piet Mondrian',NULL,1,'https://en.wikipedia.org/wiki/Piet_Mondrian',NULL);
INSERT INTO "wallpaper" VALUES (1,NULL,0,0,NULL,NULL,NULL,NULL,NULL);
COMMIT;
