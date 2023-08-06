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
	"id"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT NOT NULL,
	"description"	TEXT,
	"image_count"	INTEGER DEFAULT 0,
	"links"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "inspiration_group" (
	"id"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "showcase" (
	"id"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT NOT NULL,
	"description"	TEXT,
	"sort_mode"	TEXT DEFAULT 'latest',
	"filter_wallpaper_id"	INTEGER,
	"filter_collection_id"	INTEGER,
	"filter_artist_id"	INTEGER,
	"filter_inspiration_id"	INTEGER,
	"filter_inspiration_group_id"	INTEGER,
	"position"	INTEGER NOT NULL DEFAULT 0 UNIQUE,
	"type"	TEXT NOT NULL DEFAULT 'wallpaper_list',
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("sort_mode") REFERENCES "sort_mode"("id"),
	FOREIGN KEY("filter_wallpaper_id") REFERENCES "wallpaper"("id"),
	FOREIGN KEY("filter_collection_id") REFERENCES "collection"("id"),
	FOREIGN KEY("filter_artist_id") REFERENCES "artist"("id"),
	FOREIGN KEY("filter_inspiration_id") REFERENCES "inspiration"("id"),
	FOREIGN KEY("filter_inspiration_group_id") REFERENCES "inspiration_group"("id"),
	FOREIGN KEY("type") REFERENCES "showcase_type"("id")
);
CREATE TABLE IF NOT EXISTS "showcase_type" (
	"id"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "sort_mode" (
	"id"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id")
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
	FOREIGN KEY("artist_id") REFERENCES "artist"("id"),
	FOREIGN KEY("inspiration_id") REFERENCES "inspiration"("id")
);
INSERT INTO "artist" VALUES (1,'Yasan Glass');
INSERT INTO "collection" VALUES (1,'AMOLED mnml');
INSERT INTO "collection" VALUES (2,'mnml');
INSERT INTO "inspiration" VALUES (1,'Sunset at sea',NULL,0,NULL);
INSERT INTO "inspiration" VALUES (2,'Piet Mondrian',NULL,1,'https://en.wikipedia.org/wiki/Piet_Mondrian');
INSERT INTO "showcase" VALUES (1,'Latest Wallpapers',NULL,'latest',NULL,NULL,NULL,NULL,NULL,1,'wallpaper_list');
INSERT INTO "showcase" VALUES (2,'Random Wallpapers',NULL,'random',NULL,NULL,NULL,NULL,NULL,2,'wallpaper_list');
INSERT INTO "showcase_type" VALUES ('wallpaper');
INSERT INTO "showcase_type" VALUES ('wallpaper_list');
INSERT INTO "sort_mode" VALUES ('latest');
INSERT INTO "sort_mode" VALUES ('oldest');
INSERT INTO "sort_mode" VALUES ('random');
INSERT INTO "wallpaper" VALUES (1,'mnml 1',2500,2500,2023,10,1,1,1);
COMMIT;
