;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ARCHIVO: templates.clp
;; DESCRIPCIÓN: Define las plantillas utilizadas en el problema
;;              del Mono y la Banana.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Plantilla para representar el estado del entorno
(deftemplate estado
   (slot mono)
   (slot caja)
   (slot banana)
   (slot sobre-caja (default no))
   (slot tiene-banana (default no)))

;; Plantilla para registrar cada acción del plan
(deftemplate accion
   (slot nombre))
