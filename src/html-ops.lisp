(in-package #:html-tags)

(define-html-tag h1)
(define-html-tag h2)
(define-html-tag h3)
(define-html-tag h4)
(define-html-tag h5)
(define-html-tag h6)

(define-html-tag b)
(define-html-tag em)
(define-html-tag pre)

(define-html-tag ul)
(define-html-tag ol)
(define-html-tag li)
(define-html-tag nav :block)
(define-html-tag section :block)

(define-html-tag table :block)
(define-html-tag tbody)
(define-html-tag thead)
(define-html-tag tr)
(define-html-tag td)
(define-html-tag th)

(define-html-tag a)
(define-html-tag span)
(define-html-tag kbd)

(define-html-tag br)
(define-html-tag p :block)
(define-html-tag div :block)
(define-html-tag img)

(define-html-tag html :block)
(define-html-tag link)
(define-html-tag meta) 
(define-html-tag title)
(define-html-tag head :block)
(define-html-tag body :block)

(define-html-tag script)
(define-html-tag iframe)

(defun comment (&rest strings)
  (let ((*print-case* :downcase))
    (format nil "<!--~{ ~A~} -->" strings)))

(defun doctype (&rest strings)
  (let ((*print-case* :downcase))
    (format nil "<!DOCTYPE~{ ~A~}>" strings)))
