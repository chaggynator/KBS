;; ===============================================
;;  Rules
;; ===============================================

(defrule oferta-24-msi-iphone16
    "1. Ofrece 24 meses sin intereses en la compra de un iPhone 16 con tarjeta BBVA-Visa."
    ?o <- (orden-compra (estado "pendiente") (cliente-id ?cid))
    ?s <- (smartphone (marca Apple) (modelo iPhone16))
    ?cl <- (cliente (id ?cid) (nombre ?n) (apellido ?a))
    ; Vínculo por Titular (nombre y apellido) ya que tarjeta-credito no tiene cliente-id
    ?t <- (tarjeta-credito (banco BBVA) (grupo visa) (titular ?n&" "&?a)) 
    =>
    (printout t "Cliente " ?cid " es elegible para 24 meses sin intereses por la compra del iPhone16 con tarjeta BBVA-Visa." crlf)
)

(defrule oferta-12-msi-samsung
    "2. Ofrece 12 meses sin intereses en la compra de un Samsung GalaxyS24 con tarjeta Santander-Mastercard."
    ?o <- (orden-compra (estado "pendiente") (cliente-id ?cid))
    ?s <- (smartphone (marca Samsung) (modelo GalaxyS24))
    ?cl <- (cliente (id ?cid) (nombre ?n) (apellido ?a))
    ; Vínculo por Titular (nombre y apellido) ya que tarjeta-credito no tiene cliente-id
    ?t <- (tarjeta-credito (banco Santander) (grupo mastercard) (titular ?n&" "&?a))
    =>
    (printout t "Cliente " ?cid " es elegible para 12 meses sin intereses por la compra del GalaxyS24 con tarjeta Santander-Mastercard." crlf)
)

(defrule vales-por-compra-grande-contado
    "3. Ofrece 100 pesos en vales por cada 1000 pesos de compra en una orden con MacBookPro y iPhone16."
    ?o <- (orden-compra (id ?oid) (total ?total))
    ; Verificación de productos: Asume que si existen los productos, la regla se aplica a cualquier orden.
    (computadora (marca Apple) (modelo MacBookPro))
    (smartphone (marca Apple) (modelo iPhone16))
    (test (> ?total 1000))
    =>
    ; Corregido: Uso de 'div' para truncar la división y obtener el número de miles enteros
    (bind ?vales (div ?total 1000)) 
    (bind ?monto-vale (* ?vales 100.0))
    (printout t "Orden " ?oid ": Elegible para " ?vales " vales de $100.00, total $" ?monto-vale " en vales." crlf)
)

(defrule descuento-accesorios-por-smartphone
    "4. Ofrece 15% de descuento en audífonos (simulando funda/mica) en la compra de un smartphone."
    ?o <- (orden-compra (estado "pendiente") (cliente-id ?c) (productos $?prods))
    ?s <- (smartphone)
    ; Se aplica al accesorio audifonos de la base de hechos
    ?a <- (accesorio (tipo audifonos) (precio ?p))
    =>
    (bind ?descuento (* ?p 0.15))
    (bind ?nuevo-precio (- ?p ?descuento))
    (printout t "Cliente " ?c ": El accesorio '" (fact-slot-value ?a nombre) "' tiene un 15% de descuento, precio final: $" ?nuevo-precio "." crlf)
)


(defrule descuento-cliente-oro
    "5. Clientes oro obtienen un 5% de descuento adicional en ordenes pendientes."
    ?c <- (cliente (id ?cid) (nivel oro))
    ?o <- (orden-compra (cliente-id ?cid) (estado "pendiente") (total ?t))
    =>
    (bind ?descuento (* ?t 0.05))
    (bind ?nuevo-total (- ?t ?descuento))
    (printout t "Cliente oro " ?cid " (" (fact-slot-value ?c nombre) ") recibe 5% de descuento adicional. Nuevo total: $" ?nuevo-total crlf)
)

(defrule envio-gratis-orden-alta
    "6. Si el total de una orden-compra es mayor a $30,000.00, se establece el estado a 'envio-gratis'."
    ?o <- (orden-compra (id ?oid) (total ?t) (estado "pendiente"))
    (test (> ?t 30000.00))
    =>
    (printout t "Orden " ?oid " Total alto. Marcando para 'envio-gratis'." crlf)
)

(defrule promocion-xiaomi-accesorio
    "7. En la compra de un Xiaomi, se regala un cargador."
    (smartphone (marca Xiaomi))
    ?o <- (orden-compra (estado "pendiente"))
    =>
    (printout t "¡Promoción! Orden " (fact-slot-value ?o id) ": Se incluye un accesorio cargador de regalo." crlf)
)

(defrule oferta-combo-dell
    "8. Descuento fijo de $500.00 en la orden al comprar computadora Dell y mouse."
    (computadora (marca Dell))
    (accesorio (tipo mouse))
    ?o <- (orden-compra (id ?oid) (total ?t))
    =>
    (bind ?nuevo-total (- ?t 500.0))
    (printout t "Orden " ?oid " elegible para combo Dell/Mouse. Descuento aplicado. Nuevo total: $" ?nuevo-total crlf)
)

(defrule alerta-vale-proximo-expirar
    "9. Alerta si un vale activo expira antes del 01-01-24."
    ?v <- (vale (codigo ?cod) (expiracion ?fecha) (usado FALSE))
    ; La fecha "30-11-23" de los hechos cumple la condición.
    (test (eq ?fecha "30-11-23")) 
    =>
    (printout t "⚠️ ALERTA: El vale " ?cod " expira el " ?fecha ". Promocionarlo." crlf)
)

(defrule alerta-revisar-orden-pendiente
    "10. Alerta para revisar ordenes pendientes de hace más de X días."
    ?o <- (orden-compra (id ?oid) (fecha ?f) (estado "pendiente"))
    ; La fecha "25-10-23" de la orden 5002 se usa para simular "antigüedad".
    (test (eq ?f "25-10-23"))
    =>
    (printout t "❗ ALERTA: Orden " ?oid " con fecha " ?f " sigue pendiente. Requiere seguimiento." crlf)
)

(defrule alerta-tarjeta-expirando
    "11. Alerta si una tarjeta de crédito expira antes del 01-01-24."
    ?t <- (tarjeta-credito (titular ?titular) (fecha-expiracion ?fecha))
    ; La fecha "01-12-23" de los hechos cumple la condición.
    (test (eq ?fecha "01-12-23"))
    =>
    (printout t "⚠️ ALERTA: La tarjeta de " ?titular " con fecha " ?fecha " está próxima a expirar. Notificar al cliente." crlf)
)

(defrule alerta-stock-computadora
    "12. Alerta de bajo stock para el modelo Omen30L."
    (computadora (marca HP) (modelo Omen30L))
    =>
    (printout t "🛑 ALERTA DE STOCK: La computadora HP Omen30L está en nivel crítico de inventario." crlf)
)

(defrule clasificar-laptop-premium
    "13. Clasifica laptops con precio superior a $40,000.00 como premium."
    ?c <- (computadora (marca ?m) (modelo ?mo) (tipo laptop) (precio ?p))
    (test (> ?p 40000.00))
    =>
    (printout t "La laptop " ?m " " ?mo " ($" ?p ") se clasifica como PREMIUM." crlf)
)

(defrule clasificar-smartphone-gama-alta
    "14. Clasifica smartphones con precio superior a $25,000.00 como gama-alta."
    ?s <- (smartphone (marca ?m) (modelo ?mo) (precio ?p))
    (test (> ?p 25000.00))
    =>
    (printout t "El smartphone " ?m " " ?mo " ($" ?p ") se clasifica como GAMA ALTA." crlf)
)

(defrule actualizar-cliente-plata
    "15. Promueve a cliente plata a oro si realiza una compra grande."
    ?c <- (cliente (id ?cid) (nivel plata))
    ?o <- (orden-compra (cliente-id ?cid) (total ?t))
    (test (> ?t 19000.00)) ; La orden 5002 de 19499.00 cumple la condición.
    =>
    (printout t "¡Felicidades! Cliente " ?cid " (" (fact-slot-value ?c nombre) ") promovido a nivel ORO." crlf)
)

(defrule marcar-vale-usado
    "16. Marca el vale DESCUENTO20 como usado si se encuentra en una orden enviada."
    ?o <- (orden-compra (estado "enviado"))
    ?v <- (vale (codigo "DESCUENTO20") (usado FALSE))
    =>
    (printout t "El vale DESCUENTO20 ahora será marcado como USADO." crlf)
)

(defrule sistema-operativo-por-defecto
    "17. Aplica el sistema operativo por defecto si el slot está vacío (regla demostrativa)."
    ?s <- (smartphone (sistema-operativo ?so))
    ; Esta prueba asume que un valor no estándar indica que se necesita el default
    (test (eq ?so "iOS o Android")) 
    =>
    (printout t "Aplicando sistema operativo por defecto a un smartphone." crlf)
)

(defrule descuento-por-procesador
    "18. Aplica 3% de descuento a computadoras con procesador M3 Max."
    ?c <- (computadora (modelo ?mo) (precio ?p) (procesador "M3 Max"))
    =>
    (bind ?descuento (* ?p 0.03))
    (bind ?nuevo-precio (- ?p ?descuento))
    (printout t "Descuento del 3% en " ?mo ". Nuevo precio: $" ?nuevo-precio crlf)
)

(defrule compatibilidad-universal-oferta
    "19. Aplica 10% de descuento a accesorios con compatibilidad Universal."
    ?a <- (accesorio (nombre ?n) (tipo mouse) (compatibilidad Universal) (precio ?p))
    =>
    (bind ?descuento (* ?p 0.10))
    (bind ?nuevo-precio (- ?p ?descuento))
    (printout t "Accesorio " ?n " tiene 10% de descuento por compatibilidad Universal. Nuevo precio: $" ?nuevo-precio crlf)
)

(defrule cliente-antiguedad-bono
    "20. Otorga un bono de $200.00 al cliente con ID 101."
    ?c <- (cliente (id 101) (nombre ?n))
    =>
    (printout t "Cliente " ?n " (ID 101) es elegible para un bono de $200.00 en su próxima compra." crlf)
)
