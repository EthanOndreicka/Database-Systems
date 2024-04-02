SELECT DISTINCT d.*
FROM People p
JOIN Actors a ON p.people_id = a.people_id
JOIN Movies m ON a.actor_id = m.actor_id
JOIN Directors d ON m.director_id = d.director_id
WHERE p.name = 'Roger Moore';
