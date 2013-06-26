(defpackage :cl-hctsmsl
  (:use :cl
        :fiveam
        :alexandria)
  (:export :define-html-tag
           :make-html-form
           :html
           :make-css-form
           :css)) 

(unless (find-package :html-tags)
  (defpackage :html-tags
    (:nicknames :<)
    (:use :cl)
    (:import-from :cl-hctsmsl :define-html-tag)
    (:export :comment
             :doctype)))
