;; ----------------------------------------
;;  Facts
;; ----------------------------------------

(deffacts base-de-conocimientos-inicial

    ; HECHOS DE SMARTPHONES
    (smartphone (marca Apple) (modelo iPhone16) (color Rojo) (precio 27000.00) (sistema-operativo iOS))
    (smartphone (marca Samsung) (modelo GalaxyS24) (color Negro) (precio 18500.00) (sistema-operativo Android))
    (smartphone (marca Xiaomi) (modelo RedmiNote13) (color Azul) (precio 8999.00) (sistema-operativo Android))

    ; HECHOS DE COMPUTADORAS
    (computadora (marca Apple) (modelo MacBookPro) (tipo laptop) (precio 47000.00) (procesador "M3 Max"))
    (computadora (marca Dell) (modelo XPS15) (tipo laptop) (precio 32500.00) (procesador "Intel i9"))
    (computadora (marca HP) (modelo Omen30L) (tipo desktop) (precio 35000.00) (procesador "AMD Ryzen 7"))

    ; HECHOS DE ACCESORIOS
    (accesorio (nombre "AirPods Pro 2") (tipo audifonos) (compatibilidad iOS) (precio 5500.00))
    (accesorio (nombre "Cargador 65W") (tipo cargador) (compatibilidad USB-C) (precio 999.00))
    (accesorio (nombre "Mouse MX Master 3") (tipo mouse) (compatibilidad Universal) (precio 1800.00))

    ; HECHOS DE CLIENTES
    (cliente (id 101) (nombre "Laura") (apellido "Gómez") (email "laura@mail.com") (nivel oro))
    (cliente (id 102) (nombre "Carlos") (apellido "Pérez") (email "carlos@mail.com") (nivel plata))

    ; HECHOS DE TARJETAS DE CRÉDITO
    (tarjeta-credito (banco BBVA) (grupo visa) (titular "Laura Gómez") (fecha-expiracion "01-12-23") (ultimos-digitos 4567))
    (tarjeta-credito (banco Santander) (grupo mastercard) (titular "Carlos Pérez") (fecha-expiracion "05-08-25") (ultimos-digitos 9876))

    ; HECHOS DE VALES
    (vale (codigo "DESCUENTO20") (tipo descuento-porcentaje) (valor 20.0) (expiracion "31-12-24") (usado FALSE))
    (vale (codigo "MONTO500") (tipo descuento-monto) (valor 500.0) (expiracion "30-11-23") (usado FALSE))

    ; HECHOS DE ÓRDENES DE COMPRA
    (orden-compra (id 5001) (cliente-id 101) (productos iPhone16 AirPodsPro2) (fecha "01-10-23") (total 32500.00) (estado "enviado"))
    (orden-compra (id 5002) (cliente-id 102) (productos GalaxyS24 Cargador65W) (fecha "25-10-23") (total 19499.00) (estado "pendiente"))
)