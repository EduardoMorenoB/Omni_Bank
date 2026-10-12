UUID: el valor único aleatorio
parece un ID.

CLIENTES:
* Client_ID UUID (PK)
* Nombre             NOT NULL
* Correo             UNIQUE, NOT NULL
* Delete_at          NULL = cliente activo

CUENTAS:
* Account_ID UUID (PK)
* Client_ID UUID (FK)
* Tipo_cuenta        NOT NULL
* Saldo              CHECK >= 0
* Limite_credito     CHECK >= 0
* Moneda             NOT NULL
* Updated_at         NOT NULL

TRANSACCIONES:
* Transaction_ID UUID (PK)
* Origin_Account_ID UUID (FK)
* Destination_Account_ID UUID (FK)
* Monto              CHECK >= 0
* Tipo_transaccion   NOT NULL
* Date_TIME          NOT NULL


RELACIONES:

Clientes |───< Cuentas |───< Transacciones>───| Cuentas
                Origen                          destino