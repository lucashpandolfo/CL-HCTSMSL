(in-package :cl-hctsmsl)

(def-suite html-tests)
(def-suite css-tests)
(def-suite sanitizer-tests)

(defmethod asdf:perform ((op asdf:test-op) (component (eql (asdf:find-system :cl-hctsmsl-tests))))
  (append (fiveam:run 'sanitizer-tests)
          (fiveam:run 'html-tests)
          (fiveam:run 'css-tests)))
