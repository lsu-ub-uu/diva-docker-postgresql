DROP VIEW IF EXISTS urnnbn_daily_records;

CREATE VIEW urnnbn_daily_records AS
	SELECT
		substring(record_urnnbn->>'value' from 'urn:nbn:se:([^:-]+)') as serie,
		record_urnnbn->>'value' AS urnnbn,
		record_id->>'value' AS id,
		(record_tsVisibility->>'value')::timestamp AS ts_visibility
	FROM
		record,
		LATERAL jsonb_array_elements(data->'children') AS record_recordInfo,
		LATERAL jsonb_array_elements(record_recordInfo->'children') AS record_id,
		LATERAL jsonb_array_elements(record_recordInfo->'children') AS record_urnnbn,
		LATERAL jsonb_array_elements(record_recordInfo->'children') AS record_visibility,
		LATERAL jsonb_array_elements(record_recordInfo->'children') AS record_tsVisibility
	WHERE
		type = 'diva-output'
		AND record_recordInfo->>'name' = 'recordInfo'
		AND record_id->>'name' = 'id'
		AND record_urnnbn->>'name' = 'urn'
		AND record_visibility->>'name' = 'visibility'
		AND record_visibility->>'value' = 'published'
		AND record_tsVisibility->>'name' = 'tsVisibility'
		AND (record_tsVisibility->>'value')::timestamp >= NOW() - INTERVAL '24 hours'
	ORDER BY ts_visibility DESC;