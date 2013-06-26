(defpackage :cl-hctsmsl
  (:use :cl
        :fiveam
        :alexandria)
  (:export :define-html-tag
           :make-html-form
           :html
           :make-css-form
           :css)) 

(defpackage :html-tags
  (:nicknames :<)
  (:use :cl
        :cl-hctsmsl)
  (:export :comment
           :doctype))
