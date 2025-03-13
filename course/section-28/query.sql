-- Tags View
CREATE OR REPLACE VIEW tags AS (
	SELECT id, created_at, user_id, post_id, 'caption_tag' AS type FROM caption_tags
	UNION ALL -- do not move duplicated rows
	SELECT id, created_at, user_id, post_id, 'photo_tag' AS type FROM photo_tags
);

-- Ten most popular users (most tagged ones)
SELECT username, COUNT(*)
FROM users
JOIN tags ON tags.user_id = users.id
GROUP BY username
ORDER BY COUNT(*) DESC;

-- Ten most recent posts created
CREATE OR REPLACE VIEW recent_posts AS (
	SELECT *
	FROM posts
	ORDER BY created_at DESC
	LIMIT 10
);
