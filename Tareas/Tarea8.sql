SELECT
    transaction_id,
    amount,
    tx_type,
    tx_timestamp,
    COALESCE(
        description,
        'EXCLUSIÓN oportunamente detectada'
    ) AS descripcion_monitoreada
FROM core.transactions
WHERE
(
    (
        amount >= 1000.00
        AND tx_type IN ('TRANSFER', 'WITHDRAWAL')
    )
    OR
    (
        description ILIKE '%crypto%'
        OR description ILIKE '%offshore%'
        OR description ILIKE '%shell%'
        OR description ILIKE '%cashout%'
    )
    OR
    (
        NULLIF(TRIM(description), '') IS NULL
        AND tx_type <> 'DEPOSIT'
    )
)
ORDER BY amount DESC;

/* 

En la consulta fallida, AND se evalúa antes que OR.
Así, cualquier retiro y cualquier transacción sin
descripción activaba la alerta.

La consulta corregida agrupa el riesgo de monto
con los tipos permitidos y separa el grupo de
señales de descripción, por lo que no alerta
por descripciones omitidas en el depósito.
*/