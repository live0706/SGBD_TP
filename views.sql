-- 1. Liste de tous les workers actuels (les travailleurs toujours présents) triés par date d'arrivée (plus récent en premier)
CREATE VIEW ALL_WORKERS AS
SELECT TOP 100 PERCENT worker_id, factory_id, lastname, firstname, age, start_date
FROM (
    SELECT id AS worker_id, 1 AS factory_id, lastname, firstname, age, start_date
    FROM WORKERS_FACTORY_1 WHERE end_date IS NULL
    UNION ALL
    SELECT id AS worker_id, 2 AS factory_id, lastname, firstname, NULL AS age, start_date
    FROM WORKERS_FACTORY_2 WHERE end_date IS NULL
) AS AllWorkers
ORDER BY start_date DESC;

-- 2. Liste des workers avec leur ancienneté en jours (basée sur ALL_WORKERS)
CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT worker_id, lastname, firstname, DATEDIFF(day, start_date, GETDATE()) AS nb_days_elapsed
FROM ALL_WORKERS;

-- 3. Meilleurs fournisseurs (ceux ayant fourni plus de 1000 pièces)
CREATE VIEW BEST_SUPPLIERS AS
SELECT TOP 100 PERCENT s.name AS supplier, SUM(sp.quantity_delivered) AS nb_parts
FROM SUPPLIERS s
JOIN SPARE_PARTS sp ON sp.supplier_id = s.id
GROUP BY s.name
HAVING SUM(sp.quantity_delivered) > 1000
ORDER BY nb_parts DESC;

-- 4. Nombre de robots assemblés par usine
CREATE VIEW ROBOTS_FACTORIES AS
SELECT f.name AS factory, SUM(r.quantity) AS nb_robots
FROM FACTORIES f
JOIN ROBOTS r ON r.factory_id = f.id
GROUP BY f.name
ORDER BY nb_robots DESC;