BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "action_mode" (
	"id"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "artist" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "collection" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT UNIQUE,
	"artist_id"	INTEGER DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("artist_id") REFERENCES "artist"("id")
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
	"filter_favorite"	INTEGER,
	"show_if_empty"	INTEGER NOT NULL DEFAULT 0,
	"position"	INTEGER NOT NULL DEFAULT 0 UNIQUE,
	"type"	TEXT NOT NULL DEFAULT 'wallpaper',
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("filter_artist_id") REFERENCES "artist"("id"),
	FOREIGN KEY("filter_collection_id") REFERENCES "collection"("id"),
	FOREIGN KEY("filter_inspiration_id") REFERENCES "inspiration"("id"),
	FOREIGN KEY("filter_wallpaper_id") REFERENCES "wallpaper"("id"),
	FOREIGN KEY("sort_mode") REFERENCES "sort_mode"("id"),
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
	"variant_count"	INTEGER DEFAULT 0,
	"collection_id"	INTEGER,
	"inspiration_id"	INTEGER,
	"artist_id"	INTEGER DEFAULT 1,
	"action_mode_download"	TEXT NOT NULL DEFAULT 'premium',
	"action_mode_set"	TEXT NOT NULL DEFAULT 'enabled',
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("action_mode_download") REFERENCES "action_mode"("id"),
	FOREIGN KEY("action_mode_set") REFERENCES "action_mode"("id"),
	FOREIGN KEY("artist_id") REFERENCES "artist"("id"),
	FOREIGN KEY("collection_id") REFERENCES "collection"("id"),
	FOREIGN KEY("inspiration_id") REFERENCES "inspiration"("id")
);
INSERT INTO "action_mode" VALUES ('enabled');
INSERT INTO "action_mode" VALUES ('disabled');
INSERT INTO "action_mode" VALUES ('premium');
INSERT INTO "artist" VALUES (1,'Yasan Glass');
INSERT INTO "collection" VALUES (1,'AMOLED mnml',1);
INSERT INTO "collection" VALUES (2,'mnml',1);
INSERT INTO "content_type" VALUES ('wallpaper');
INSERT INTO "inspiration" VALUES (1,'Sunset at sea',NULL,0,NULL);
INSERT INTO "inspiration" VALUES (2,'Piet Mondrian',NULL,1,'https://en.wikipedia.org/wiki/Piet_Mondrian');
INSERT INTO "showcase" VALUES (1,'Latest Wallpapers',NULL,'latest',NULL,NULL,NULL,NULL,NULL,0,1,'wallpaper');
INSERT INTO "showcase" VALUES (2,'Random Wallpapers',NULL,'random',NULL,NULL,NULL,NULL,NULL,0,2,'wallpaper');
INSERT INTO "showcase" VALUES (3,'Favorite Wallpapers','Your favorite wallpapers are all here!','latest',NULL,NULL,NULL,NULL,1,0,0,'wallpaper');
INSERT INTO "sort_mode" VALUES ('latest');
INSERT INTO "sort_mode" VALUES ('oldest');
INSERT INTO "sort_mode" VALUES ('random');
INSERT INTO "wallpaper" VALUES (1,'mnml 1',2500,2500,2023,0,1,1,1,'premium','enabled');
INSERT INTO "wallpaper" VALUES (2,'mnml 2',2500,2500,2023,0,1,NULL,1,'premium','enabled');
INSERT INTO "wallpaper" VALUES (3,'mnml 3',2500,2500,2023,0,2,NULL,1,'premium','enabled');
INSERT INTO "wallpaper" VALUES (4,'pro 1',2500,2500,2023,0,2,NULL,1,'premium','enabled');
INSERT INTO "wallpaper" VALUES (5,'no action',2500,2500,2023,0,NULL,NULL,1,'disabled','disabled');
INSERT INTO "wallpaper" VALUES (6,'With variants',3200,2560,2010,7,NULL,NULL,1,'premium','enabled');
COMMIT;
