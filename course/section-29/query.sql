-- Produce a view with likes per week
CREATE MATERIALIZED VIEW weekly_likes AS (
	SELECT 
		-- Use coalesce function to use posts or comments creation date, first found
		date_trunc('week', COALESCE(posts.created_at, comments.created_at)) as week,
		COUNT(posts.id) AS num_likes_for_posts,
		COUNT(comments.id) AS num_likes_for_comments
	FROM likes
	-- both left join to not skip null references for posts or comments rows
	LEFT JOIN posts ON posts.id = likes.post_id
	LEFT JOIN comments ON comments.id = likes.comment_id
	GROUP BY week
	ORDER BY week -- default is ASC
) WITH DATA; -- will populate the view in the first time execution

-- Refresh
REFRESH MATERIALIZED VIEW weekly_likes;
