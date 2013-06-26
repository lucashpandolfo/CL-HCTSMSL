(defpackage :cl-hctsmsl
  (:use :cl
        :fiveam
        :alexandria)
  (:export :define-html-tag
           :make-css-form
           :css-form)) 

(defpackage :html-tags
  (:nicknames :<)
  (:use :cl
        :cl-hctsmsl)
  (:export :comment
           :doctype))
