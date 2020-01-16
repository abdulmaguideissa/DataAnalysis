/*
	Find the number of events that occurred for each day for each channel.
	Create a subquery that returns all the information from the first query. 
	Find the average number of events for each channel. 
*/
SELECT channel, AVG(events_count) AS avg_events
	FROM (
		SELECT DATE_TRUNC('day', occurred_at) AS day,
			channel, 
			COUNT(*) AS events_count
			FROM web_events
			GROUP BY 1, 2
			ORDER BY day) sub
	GROUP BY channel
	ORDER BY avg_events DESC;
 
