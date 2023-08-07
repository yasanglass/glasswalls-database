BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "artist" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "collection" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "content_type" (
	"id"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "inspiration" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	"image_count"	INTEGER DEFAULT 0,
	"links"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "showcase" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	"sort_mode"	TEXT DEFAULT 'latest',
	"filter_wallpaper_id"	INTEGER,
	"filter_collection_id"	INTEGER,
	"filter_artist_id"	INTEGER,
	"filter_inspiration_id"	INTEGER,
	"position"	INTEGER NOT NULL DEFAULT 0 UNIQUE,
	"type"	TEXT NOT NULL DEFAULT 'wallpaper',
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("sort_mode") REFERENCES "sort_mode"("id"),
	FOREIGN KEY("filter_wallpaper_id") REFERENCES "wallpaper"("id"),
	FOREIGN KEY("filter_collection_id") REFERENCES "collection"("id"),
	FOREIGN KEY("filter_artist_id") REFERENCES "artist"("id"),
	FOREIGN KEY("filter_inspiration_id") REFERENCES "inspiration"("id"),
	FOREIGN KEY("type") REFERENCES "content_type"("id")
);
CREATE TABLE IF NOT EXISTS "sort_mode" (
	"id"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "wallpaper" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT UNIQUE,
	"width"	INTEGER NOT NULL,
	"height"	INTEGER NOT NULL,
	"year"	INTEGER,
	"collection_id"	INTEGER,
	"inspiration_id"	INTEGER,
	"artist_id"	INTEGER DEFAULT 1,
	FOREIGN KEY("collection_id") REFERENCES "collection"("id"),
	FOREIGN KEY("artist_id") REFERENCES "artist"("id"),
	FOREIGN KEY("inspiration_id") REFERENCES "inspiration"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "artist" VALUES (1,'Yasan Glass');
INSERT INTO "collection" VALUES (1,'AMOLED mnml');
INSERT INTO "collection" VALUES (2,'mnml');
INSERT INTO "content_type" VALUES ('wallpaper');
INSERT INTO "inspiration" VALUES (1,'Sunset at sea',NULL,0,NULL);
INSERT INTO "inspiration" VALUES (2,'Piet Mondrian',NULL,1,'https://en.wikipedia.org/wiki/Piet_Mondrian');
INSERT INTO "showcase" VALUES (1,'Latest Wallpapers',NULL,'latest',NULL,NULL,NULL,NULL,1,'wallpaper');
INSERT INTO "showcase" VALUES (2,'Random Wallpapers',NULL,'random',NULL,NULL,NULL,NULL,2,'wallpaper');
INSERT INTO "sort_mode" VALUES ('latest');
INSERT INTO "sort_mode" VALUES ('oldest');
INSERT INTO "sort_mode" VALUES ('random');
INSERT INTO "wallpaper" VALUES (1,'mnml 1',2500,2500,2023,1,1,1);
INSERT INTO "wallpaper" VALUES (2,'mnml 2',2500,2500,2023,NULL,NULL,1);
INSERT INTO "wallpaper" VALUES (3,'mnml 3',2500,2500,2023,NULL,NULL,1);
COMMIT;
