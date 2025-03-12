-- Recursive query example
-- Retrieve a list of users suggestions to follow (structure here is a graph, but could be a tree)
WITH RECURSIVE suggestions (leader_id, follower_id, depth) AS (
		-- First part in the non-recursive query
		SELECT leader_id, follower_id, 1 AS depth
		FROM followers
		WHERE follower_id = 1 -- hardcoded user id
	UNION
		-- Second part in the recursive query
		SELECT followers.leader_id, followers.follower_id, depth + 1 -- increment depth level
		FROM followers
		JOIN suggestions ON suggestions.leader_id = followers.follower_id
		WHERE depth < 3
)
SELECT DISTINCT users.id, users.username
FROM suggestions
JOIN users ON users.id = suggestions.leader_id
WHERE depth > 1
LIMIT 30;
