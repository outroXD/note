# MySQL

# N-Gram 全文検索
```mysql
INSERT INTO keisuke.sample_like VALUES (1, "this is title", "これはテキスト本文1です。");
INSERT INTO keisuke.sample_like_detail VALUES (1, "this is title detail");
INSERT INTO keisuke.sample_like VALUES (2, "that is title", "これはテキスト本文2です。");
INSERT INTO keisuke.sample_like_detail VALUES (2, "that is title detail");
INSERT INTO keisuke.sample_like VALUES (3, "this is title", "これはテキスト本文3です。");
INSERT INTO keisuke.sample_like_detail VALUES (3, "that is title detail");
INSERT INTO keisuke.sample_like VALUES (4, "that is title", "これはテキスト本文4です。");
INSERT INTO keisuke.sample_like_detail VALUES (4, "this is title detail");
INSERT INTO keisuke.sample_like VALUES (5, "this is title", "これはテキスト本文5です。");
INSERT INTO keisuke.sample_like_detail VALUES (5, "this is title detail");
commit ;

-- 'this'に部分一致するtitleがあるレコード かつ 'this'に部分一致するsld.detailがあるレコード。
SELECT
    sl.id, sl.title, sl.text,
    sld.id, sld.title
    FROM keisuke.sample_like sl
    LEFT JOIN keisuke.sample_like_detail sld on sl.id = sld.id
    WHERE sl.title LIKE '%this%'
      AND sld.title LIKE '%this%';

-- 'これ'に部分一致するtextがあるレコードのみ取得。
SELECT
    sl.id, sl.title, sl.text,
    sld.id, sld.title
    FROM keisuke.sample_like sl
    LEFT JOIN keisuke.sample_like_detail sld on sl.id = sld.id
    WHERE sl.text LIKE '%これ%'
        AND sl.text LIKE '%5%';


-- N-gram INDEXで高速化
CREATE TABLE sample_like_2 (id INTEGER, title VARCHAR(150), text TEXT) ENGINE=InnoDB CHARACTER SET utf8mb4;
CREATE TABLE sample_like_detail_2 (id INTEGER, title VARCHAR(150)) ENGINE=InnoDB CHARACTER SET utf8mb4;
ALTER TABLE sample_like_2 ADD FULLTEXT INDEX ngram_index_sample_like_2 (title, text) WITH PARSER ngram;
ALTER TABLE sample_like_detail_2 ADD FULLTEXT INDEX ngram_index_sample_like_detail_2 (title) WITH PARSER ngram;

-- SUPER権限がないため、メタ情報が見れなかった。権限を付与する。
-- rootユーザーでMySQLにログイン後、以下SQLを通して設定する。
SELECT user, Super_priv FROM mysql.user WHERE user='keisuke';
UPDATE mysql.user SET Super_priv='Y' WHERE user = 'keisuke';
COMMIT;

-- メタ情報をみてみる
SELECT * FROM information_schema.INNODB_SYS_TABLES;

-- OPTIMIZE時に全文検索インデックスを再構築するフラグを立てる
SET GLOBAL innodb_optimize_fulltext_only=ON;
-- 全文検索インデックスを再構築する
OPTIMIZE TABLE sample_like_2;
SET GLOBAL innodb_ft_aux_table="keisuke/sample_like_2";
SELECT * FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_TABLE LIMIT 15;


-- 2-gram インデックス試作
CREATE DATABASE fts;
USE fts;
CREATE TABLE documents (id SERIAL PRIMARY KEY, content VARCHAR(255),
FULLTEXT(content) WITH PARSER ngram) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO documents (content) VALUES ('すもももももももものうち'),
                                       ('おおきなももがどんぶらこ、どんぶらことながれてきました'),
                                       ('abc'),
                                       ('けっなんで'),
                                       ('keisuke');

-- content2の先頭2文字がインデックスされない
# CREATE TABLE documents (id SERIAL PRIMARY KEY, content VARCHAR(255), content2 VARCHAR(255),
# FULLTEXT(content, content2) WITH PARSER ngram) CHARACTER SET utf8;

-- 上記と同じ結果
# CREATE TABLE documents (id SERIAL PRIMARY KEY, content VARCHAR(255), content2 VARCHAR(255),
# FULLTEXT(content) WITH PARSER ngram, FULLTEXT(content2) WITH PARSER ngram)
# ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

# INSERT INTO documents (content, content2) VALUES ('すもももももももものうち', 'おおyeah'),
#                                                  ('おおきなももがどんぶらこ、どんぶらことながれてきました', 'abc'),
#                                                  ('keisukeです。', 'gggggguni-t');

SELECT * FROM documents WHERE MATCH (content) AGAINST ('ke');
SET GLOBAL innodb_ft_aux_table = 'fts/documents';
SELECT * FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_CACHE;

-- Stop wordの使用をOFFにする
-- 意図しないN-gramトークン破棄対策
SHOW VARIABLES LIKE 'innodb_ft_enable_stopword';
SET GLOBAL innodb_ft_enable_stopword = OFF;
```
```ini
[mysqld]
general_log=1
general_log_file=/var/log/mysql/general-query.log
# 日本語は1語で意味を持つことが普通にあるので、1に設定
ft_min_word_len=1
innodb_ft_min_token_size=1
# デフォルトで設定されている停止語を使ったトークナイズをOFF
innodb_ft_enable_stopword = OFF
ngram_token_size=2
```