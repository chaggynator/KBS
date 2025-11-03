;; ----------------------------------------
;;  Templates
;; ----------------------------------------

(deftemplate smartphone
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio (type NUMBER))
   (slot sistema-operativo (default "iOS o Android"))
)

(deftemplate computadora
   (slot marca)
   (slot modelo)
   (slot tipo (allowed-values laptop desktop))
   (slot precio (type NUMBER))
   (slot procesador)
)

(deftemplate accesorio
   (slot nombre)
   (slot tipo (allowed-values audifonos cargador mouse teclado funda))
   (slot compatibilidad)
   (slot precio (type NUMBER))
)

(deftemplate cliente
   (slot id (type INTEGER))
   (slot nombre)
   (slot apellido)
   (slot email)
   (slot nivel (allowed-values bronce plata oro))
)

(deftemplate orden-compra
   (slot id (type INTEGER))
   (slot cliente-id (type INTEGER))
   (multislot productos) ; Lista de IDs de productos comprados
   (slot fecha)
   (slot total (type NUMBER))
   (slot estado (default "pendiente"))
)

(deftemplate tarjeta-credito
   (slot banco)
   (slot grupo (allowed-values visa mastercard amex))
   (slot titular)
   (slot fecha-expiracion) ; Formato DD-MM-AA
   (slot ultimos-digitos (type INTEGER))
)

(deftemplate vale
   (slot codigo)
   (slot tipo (allowed-values descuento-porcentaje descuento-monto))
   (slot valor (type NUMBER)) ; Porcentaje o monto
   (slot expiracion) ; Fecha de expiración DD-MM-AA
   (slot usado (default FALSE))
)


