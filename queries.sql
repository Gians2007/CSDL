USE photography_mini;

    s.shoot_id,
    s.shoot_date,
    c.client_id,
    c.full_name AS client_name,
    p.photographer_id,
    p.full_name AS photographer_name,
    s.location
FROM shoots s
INNER JOIN clients c ON s.client_id = c.client_id
INNER JOIN photographers p ON s.photographer_id = p.photographer_id
WHERE s.status = 'Completed'
  AND s.shoot_date >= '2025-01-01'
  AND s.shoot_date <= '2025-01-31'
ORDER BY s.shoot_date ASC, s.shoot_id ASC;

SELECT
    pg.group_id,
    pg.name AS group_name,
    COUNT(s.shoot_id) AS total_shoots_q1_2025
FROM photo_groups pg
LEFT JOIN photographers p ON pg.group_id = p.group_id
LEFT JOIN shoots s ON p.photographer_id = s.photographer_id
    AND s.shoot_date >= '2025-01-01'
    AND s.shoot_date <= '2025-03-31'
GROUP BY pg.group_id, pg.name
ORDER BY pg.group_id ASC;

SELECT DISTINCT
    c.client_id,
    c.full_name AS client_name,
    c.phone,
    c.email
FROM clients c
INNER JOIN shoots s ON c.client_id = s.client_id
LEFT JOIN deliveries d ON s.shoot_id = d.shoot_id
WHERE s.status <> 'Cancelled'
  AND d.delivery_id IS NULL
ORDER BY c.client_id ASC;

SELECT
    pg.group_id,
    pg.name AS group_name,
    COUNT(d.delivery_id) AS completed_shoot_count,
    ROUND(AVG(d.fee), 2) AS avg_completed_fee
FROM photo_groups pg
INNER JOIN photographers p ON pg.group_id = p.group_id
INNER JOIN shoots s ON p.photographer_id = s.photographer_id
INNER JOIN deliveries d ON s.shoot_id = d.shoot_id
WHERE s.status = 'Completed'
GROUP BY pg.group_id, pg.name
HAVING SUM(d.fee) > 0
ORDER BY pg.group_id ASC;

SELECT
    p.photographer_id,
    p.full_name AS photographer_name,
    p.specialty,
    COUNT(s.shoot_id) AS completed_shoots_2025
FROM photographers p
INNER JOIN shoots s ON p.photographer_id = s.photographer_id
WHERE s.status = 'Completed'
  AND s.shoot_date >= '2025-01-01'
  AND s.shoot_date <= '2025-12-31'
GROUP BY p.photographer_id, p.full_name, p.specialty
HAVING COUNT(s.shoot_id) > 0
ORDER BY completed_shoots_2025 DESC, p.photographer_id ASC
LIMIT 3;

SELECT
    c.client_id,
    c.full_name AS client_name,
    COALESCE(SUM(pay2025.amount), 0.00) AS total_paid_2025
FROM clients c
LEFT JOIN (
    SELECT
        s.client_id,
        p.amount
    FROM shoots s
    INNER JOIN payments p ON s.shoot_id = p.shoot_id
    WHERE p.payment_date >= '2025-01-01'
      AND p.payment_date <= '2025-12-31'
) pay2025 ON c.client_id = pay2025.client_id
GROUP BY c.client_id, c.full_name
ORDER BY c.client_id ASC;

SELECT
    c.client_id,
    c.full_name AS client_name,
    c.phone,
    c.email
FROM clients c
LEFT JOIN shoots s ON c.client_id = s.client_id
LEFT JOIN payments p ON s.shoot_id = p.shoot_id
GROUP BY c.client_id, c.full_name, c.phone, c.email
HAVING COUNT(p.payment_id) = 0
ORDER BY c.client_id ASC;

SELECT
    c.client_id,
    c.full_name AS client_name,
    COALESCE(SUM(d.fee), 0.00) AS total_confirmed_fee
FROM clients c
LEFT JOIN shoots s ON c.client_id = s.client_id
LEFT JOIN deliveries d ON s.shoot_id = d.shoot_id
GROUP BY c.client_id, c.full_name
ORDER BY total_confirmed_fee DESC, c.client_id ASC;

SELECT
    p.photographer_id,
    p.full_name AS photographer_name,
    COUNT(s.shoot_id) AS total_shoots_2025,
    SUM(CASE WHEN s.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_shoots_2025,
    CASE
        WHEN COUNT(s.shoot_id) = 0 THEN NULL
        ELSE ROUND(
            (SUM(CASE WHEN s.status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0)
            / COUNT(s.shoot_id),
            2
        )
    END AS cancellation_rate_percent
FROM photographers p
LEFT JOIN shoots s ON p.photographer_id = s.photographer_id
    AND s.shoot_date >= '2025-01-01'
    AND s.shoot_date <= '2025-12-31'
GROUP BY p.photographer_id, p.full_name
ORDER BY p.photographer_id ASC;

SELECT
    c.client_id,
    c.full_name AS client_name,
    COUNT(s.shoot_id) AS completed_count_2025
FROM clients c
INNER JOIN shoots s ON c.client_id = s.client_id
WHERE s.status = 'Completed'
  AND s.shoot_date >= '2025-01-01'
  AND s.shoot_date <= '2025-12-31'
GROUP BY c.client_id, c.full_name
HAVING COUNT(s.shoot_id) > 3
ORDER BY completed_count_2025 DESC, c.client_id ASC;
