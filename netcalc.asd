;;;; netcalc.asd

(asdf:defsystem #:netcalc
  :description "Netcalc is a CLI program for performing network related calculations"
  :author "Benjámin J. Ferge <benjamin.ferge@protonmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "netcalc")))
