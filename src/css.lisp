(in-package #:cl-hctsmsl)

(defmacro with-chain-selector (character &body arguments)
  `(format nil
           ,(concatenate 'string
                         "~{~@{~#[~;~A~:;~A " character " ~]~}~}")
           ,@arguments))

(defun make-attrubute-selector (list)
  (destructuring-bind (type . attributes) list
    (format nil "~A[~{~A=\"~A\"~#[~:; ~]~}]"
            (if type
              type
              "")
            attributes)))

(defun make-parent-selector (data)
  (if (not (listp data))
      data
      (destructuring-bind (type parent option) data
        (case (intern (string-upcase type) (find-package 'keyword))
          (:class    (format nil "~A.~A" parent option))
          (:id       (format nil "~A#~A" parent option))
          (otherwise "")))))

(defun make-child-selector (list)
  (with-chain-selector ">"
    (mapcar #'make-parent-selector list))) 

(defun make-after-selector (list)
  (with-chain-selector "+"
    (mapcar #'make-parent-selector list))) 

(defun make-pseudoclass-selector (list)
  (destructuring-bind (tag class) list
    (format nil "~A:~A" tag class)))

(defun make-pseudoelt-selector (list)
  (destructuring-bind (tag elt) list
    (format nil "~A::~A" tag elt)))

(defun make-selector (list)
  (destructuring-bind (type . options) list
    (case type
      (:element     (format nil "~{~A ~}" options))
      (:class       (format nil "~{.~A ~}" options))
      (:id          (format nil "~{#~A ~}" options))
      (:attribute   (format nil "~{~A ~}" (mapcar #'make-attrubute-selector options)))
      (:parent      (format nil "~{~A ~}" (mapcar #'make-parent-selector options)))
      (:child       (format nil "~A " (make-child-selector options)))
      (:after       (format nil "~A " (make-after-selector options)))
      (:pseudoclass (format nil "~{~A ~}" (mapcar #'make-pseudoclass-selector options)))
      (:pseudoelt   (format nil "~{~A ~}" (mapcar #'make-pseudoelt-selector options))))))

(defun make-property-specifier (list)
  (destructuring-bind (property value) list
    (format nil "~A: ~A;" property value)))

(defun make-properties-block (list)
  (format nil "{~&~{~4T~A~&~}}" (mapcar #'make-property-specifier list)))

(defun make-css-form (selector properties)
  (let ((*print-case* :downcase))
    (concatenate 'string
                 (make-selector selector)
                 (make-properties-block properties))))

(defmacro css (selector &body properties)
  `(make-css-form ',selector ',properties))
