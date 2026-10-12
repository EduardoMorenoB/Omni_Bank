-- 1. Movimientos superiores al promedio

SELECT
    t.transaction_id,
    t.account_id,
    a.account_number,
    t.amount,
    (
        SELECT AVG(t2.amount)
        FROM core.transactions AS t2
        WHERE t2.account_id = t.account_id
    ) AS promedio_cuenta
FROM core.transactions AS t
INNER JOIN core.accounts AS a
    ON a.account_id = t.account_id
WHERE t.amount > (
    SELECT AVG(t3.amount)
    FROM core.transactions AS t3
    WHERE t3.account_id = t.account_id
)
ORDER BY a.account_number, t.transaction_id;


-- 2. Promedio agrupado

SELECT
    a.account_number,
    COUNT(t.transaction_id) AS total_movimientos,
    AVG(t.amount) AS promedio_cuenta
FROM core.accounts AS a
LEFT JOIN core.transactions AS t
    ON t.account_id = a.account_id
GROUP BY a.account_id, a.account_number
ORDER BY a.account_number;


-- 3. Cuentas sin movimientos con NOT EXISTS

SELECT
    a.account_number,
    a.is_active
FROM core.accounts AS a
WHERE NOT EXISTS (
    SELECT 1
    FROM core.transactions AS t
    WHERE t.account_id = a.account_id
)
ORDER BY a.account_number;