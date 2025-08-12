;; Decentralized Class Roster Contract (fixed)
;; Only two public functions: add-student and remove-student

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-student-exists (err u101))
(define-constant err-student-not-found (err u102))

;; students map: principal => bool
(define-map students principal bool)

;; Add a student (only owner)
(define-public (add-student (student principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (is-none (map-get? students student)) err-student-exists)
    (map-set students student true)
    ;; return the added principal (or use (ok true) if you prefer)
    (ok student)
  )
)

;; Remove a student (only owner)
(define-public (remove-student (student principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (is-some (map-get? students student)) err-student-not-found)
    (map-delete students student)
    (ok student)
  )
)



