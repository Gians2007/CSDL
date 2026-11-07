USE photography_mini;


CREATE OR REPLACE VIEW v_detail AS
SELECT
    s.shoot_id,
    s.shoot_date,
    s.status,
    c.full_name AS client_name,
    p.full_name AS photographer_name,
    pg.name AS group_name,
    d.fee
FROM shoots s
INNER JOIN clients c ON s.client_id = c.client_id
INNER JOIN photographers p ON s.photographer_id = p.photographer_id
INNER JOIN photo_groups pg ON p.group_id = pg.group_id
LEFT JOIN deliveries d ON s.shoot_id = d.shoot_id;

CREATE OR REPLACE VIEW v_group_summary AS
SELECT
    pg.group_id,
    pg.name AS group_name,
    COUNT(s.shoot_id) AS total_shoots,
    COALESCE(SUM(CASE WHEN s.status = 'Completed' THEN 1 ELSE 0 END), 0) AS completed_shoots,
    COALESCE(SUM(CASE WHEN s.status = 'Cancelled' THEN 1 ELSE 0 END), 0) AS cancelled_shoots,
    COALESCE(SUM(d.fee), 0.00) AS total_fee
FROM photo_groups pg
LEFT JOIN photographers p ON pg.group_id = p.group_id
LEFT JOIN shoots s ON p.photographer_id = s.photographer_id
LEFT JOIN deliveries d ON s.shoot_id = d.shoot_id
GROUP BY pg.group_id, pg.name;

CREATE OR REPLACE VIEW v_debt AS
SELECT
    c.client_id,
    c.full_name AS client_name,
    COALESCE(f.total_confirmed_fee, 0.00) AS total_confirmed_fee,
    COALESCE(pay.total_paid, 0.00) AS total_paid,
    COALESCE(f.total_confirmed_fee, 0.00) - COALESCE(pay.total_paid, 0.00) AS remaining_debt
FROM clients c
LEFT JOIN (
    SELECT
        s.client_id,
        SUM(d.fee) AS total_confirmed_fee
    FROM shoots s
    INNER JOIN deliveries d ON s.shoot_id = d.shoot_id
    GROUP BY s.client_id
) f ON c.client_id = f.client_id
LEFT JOIN (
    SELECT
        s.client_id,
        SUM(p.amount) AS total_paid
    FROM shoots s
    INNER JOIN payments p ON s.shoot_id = p.shoot_id
    GROUP BY s.client_id
) pay ON c.client_id = pay.client_id;
