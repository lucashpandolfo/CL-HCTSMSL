(defpackage :cl-hctsmsl-system
  (:use :cl
        :asdf))

(in-package :cl-hctsmsl-system)

(defsystem :cl-hctsmsl
  :description "Library to generate human-readable HTML and CSS forms."
  :author "Mark Fedurin <hitecnologys@gmail.com>"
  :license "GPL v3"
  :version "1.0.0"
  :defsystem-depends-on (:alexandria :fiveam)
  :pathname "src"
  :components ((:file "packages")
               (:file "html")
               (:file "css")
               (:file "html-ops")))

(defsystem :cl-hctsmsl-tests
  :description "Set of unit-tests for CL-HCTSMSL."
  :defsystem-depends-on (:cl-hctsmsl)
  :pathname "tests"
  :components ((:file "suites")
               (:file "html-tests")
               (:file "css-tests")))

(defmethod perform ((op test-op) (component (eql (find-system :cl-hctsmsl))))
  (operate 'load-op :cl-hctsmsl)
  (operate 'test-op :cl-hctsmsl-tests))
