WITH y AS (
  SELECT
    id,
    unnest(xpath('//food_item_id/text()', menu_data))::text AS food_item_id
  FROM
    christmas_menus
  WHERE
    (xpath('string(/*/@version)', menu_data))[1]::text = '1.0'
    AND (xpath('string(/northpole_database/annual_celebration/event_metadata/dinner_details/guest_registry/total_count)', menu_data))[1]::text::int > 78

  UNION

  SELECT
    id,
    unnest(xpath('//food_item_id/text()', menu_data))::text AS food_item_id
  FROM
    christmas_menus
  WHERE
    (xpath('string(/*/@version)', menu_data))[1]::text = '2.0'
    AND (xpath('string(/christmas_feast/organizational_details/attendance_record/total_guests)', menu_data))[1]::text::int > 78

  UNION

  SELECT
    id,
    unnest(xpath('//food_item_id/text()', menu_data))::text AS food_item_id
  FROM
    christmas_menus
  WHERE
    (xpath('string(/*/@version)', menu_data))[1]::text = '3.0'
    AND (xpath('string(/polar_celebration/event_administration/participant_metrics/attendance_details/headcount/total_present)', menu_data))[1]::text::int > 78
)

SELECT
  food_item_id,
  COUNT(food_item_id) AS occurrences
FROM
  y
GROUP BY
  food_item_id
ORDER BY
  occurrences DESC,
  food_item_id;
