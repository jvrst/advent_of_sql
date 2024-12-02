select c.name,
 wl.wishes->'first_choice' as primary_wish,
 wl.wishes->'second_choice' as backup_wish,
 wl.wishes->'colors'->0 as favorite_color,
 json_array_length(wl.wishes->'colors') AS color_count,
 case
  when tc.category = 'outdoor' THEN 'Outside Workshop'
  when tc.category = 'educational' THEN 'Learning Workshop'
 ELSE
    'General Workshop'
 END AS workshop_assignment,
 CASE
   WHEN tc.difficulty_to_make = 1 THEN 'Simple Gift'
   WHEN tc.difficulty_to_make = 2 THEN 'Moderate Gift'
   WHEN tc.difficulty_to_make >= 3 THEN 'Complex Gift'
 END AS gift_complexity
from wish_lists wl 
join children c on c.child_id = wl.child_id 
join toy_catalogue tc on wl.wishes->>'first_choice' = tc.toy_name
order by c.name 
limit 5


