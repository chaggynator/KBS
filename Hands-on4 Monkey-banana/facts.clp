;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ARCHIVO: facts.clp
;; DESCRIPCIÓN: Define los hechos iniciales del problema
;;              del Mono y la Banana.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Estado inicial del mundo
(deffacts estado-inicial
   (estado (mono piso) (caja esquina) (banana techo) (sobre-caja no) (tiene-banana no))
   (accion (nombre inicio)))
