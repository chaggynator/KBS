;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ARCHIVO: rules.clp
;; DESCRIPCIÓN: Reglas del sistema experto del Mono y la Banana
;;              (versión corregida sin error de retract)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 1. El mono camina hacia la caja
(defrule caminar-hacia-caja
   ?e <- (estado (mono piso) (caja esquina) (banana techo) (sobre-caja no) (tiene-banana no))
   =>
   (printout t "El mono camina hacia la caja." crlf)
   (retract ?e)
   (assert (estado (mono caja) (caja esquina) (banana techo) (sobre-caja no) (tiene-banana no)))
   (assert (accion (nombre "Caminar hacia la caja"))))

;; 2. El mono empuja la caja debajo de la banana
(defrule empujar-caja-bajo-banana
   ?e <- (estado (mono caja) (caja esquina) (banana techo) (sobre-caja no) (tiene-banana no))
   =>
   (printout t "El mono empuja la caja debajo de la banana." crlf)
   (retract ?e)
   (assert (estado (mono caja) (caja banana) (banana techo) (sobre-caja no) (tiene-banana no)))
   (assert (accion (nombre "Empujar la caja debajo de la banana"))))

;; 3. El mono se sube a la caja
(defrule subirse-a-la-caja
   ?e <- (estado (mono caja) (caja banana) (banana techo) (sobre-caja no) (tiene-banana no))
   =>
   (printout t "El mono se sube a la caja." crlf)
   (retract ?e)
   (assert (estado (mono banana) (caja banana) (banana techo) (sobre-caja si) (tiene-banana no)))
   (assert (accion (nombre "Subirse a la caja"))))

;; 4. El mono toma la banana
(defrule tomar-banana
   ?e <- (estado (mono banana) (caja banana) (banana techo) (sobre-caja si) (tiene-banana no))
   =>
   (printout t "El mono toma la banana." crlf)
   (retract ?e)
   (assert (estado (mono banana) (caja banana) (banana techo) (sobre-caja si) (tiene-banana si)))
   (assert (accion (nombre "Tomar la banana"))))

;; 5. El mono come la banana (estado meta)
(defrule comer-banana
   (estado (tiene-banana si))
   =>
   (printout t "El mono come la banana. 🐒🍌" crlf)
   (assert (accion (nombre "Comer la banana")))
   (printout t crlf "=== PLAN COMPLETO ===" crlf)
   (do-for-all-facts ((?a accion)) TRUE
      (printout t "- " (fact-slot-value ?a nombre) crlf))
   (printout t "======================" crlf))
