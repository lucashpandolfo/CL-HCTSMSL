(in-package :cl-hctsmsl)

(defparameter *indent-size* 4)

(defun generate-indent (size)
  (if (zerop size)
      ""
      (format nil "~vT" size)))

(defun indent-string (size string)
  (concatenate 'string
               (generate-indent size)
               string))

(defun make-opening-tag (name parameters)
  (let ((*print-case* :downcase))
    (format nil "<~A~{ ~A=\"~A\"~}>"
            name parameters)))

(defun make-closing-tag (name)
  (let ((*print-case* :downcase))
    (format nil "</~A>"
            name)))

(defun parameters-form-p (form)
  (and (listp form) (not (eql (first form) :html-form))))

(defun make-raw-html-form (tag parameters content &optional (force-formatting-mode :auto))
  "Formatting mode can be either :auto (decides which representation to choose based on content), :inline (forces translator to use inline mod) or :block (forces translator to use block mode). If other value supplied, it generates an error."
  (append (list :html-form)
          (list force-formatting-mode)
          (list (make-opening-tag tag (when (parameters-form-p parameters)
                                        parameters)))
          (list (make-closing-tag tag))
          (if (parameters-form-p parameters) content (cons parameters content))))

(defun make-html-form (form)
  (with-output-to-string (stream)
    (labels
        ((write-with-indent (string size)
           (princ (indent-string size string)
                  stream))

         (write-without-indent (string)
           (princ string
                  stream))

         (write-inline (tag closing-tag content indentation-level)
           (write-with-indent tag indentation-level)
           (dolist (form content)
             (if (listp form)
                 (walk-tree form 0)
                 (write-without-indent form)))
           (write-without-indent closing-tag))

         (write-block (tag closing-tag content indentation-level)
           (write-with-indent tag indentation-level)
           (fresh-line stream)
           (dolist (form content)
             (if (listp form)
                 (walk-tree form (+ indentation-level *indent-size*))
                 (write-with-indent form (+ indentation-level *indent-size*)))
             (fresh-line stream))
           (fresh-line stream)
           (write-with-indent closing-tag indentation-level))

         (write-auto (tag closing-tag content indentation-level)
           (if (< 1 (length content))
               (write-block tag closing-tag content indentation-level)
               (write-inline tag closing-tag content indentation-level)))

         (walk-tree (expression &optional (indentation-level 0))
           (if (not (listp expression))
               (write-with-indent expression indentation-level)
               (destructuring-bind (form-type formatting-mode tag closing-tag . content) expression
                 (declare (ignore form-type))
                 (if (not content)
                     (write-with-indent tag (if (eql formatting-mode :inline) 0 indentation-level))
                     (case formatting-mode
                       (:inline (write-inline tag closing-tag content indentation-level))
                       (:block  (write-block tag closing-tag content indentation-level))
                       (:auto   (write-auto tag closing-tag content indentation-level))
                       (t       (error "Unknown formatting mode: ~S" formatting-mode))))))))

      (walk-tree form))))

(defun make-html-forms (&rest forms)
  (reduce (curry #'concatenate 'string)
          forms
          :key (compose (curry #'format nil "~A~%") #'make-html-form)))

(defmacro define-html-tag (name &optional forced-mode)
  `(progn (defun ,(intern (symbol-name name) (find-package :html-tags)) (parameters &rest forms)
            (make-raw-html-form ',name parameters forms
                                ,(if forced-mode
                                     forced-mode
                                     :auto)))
          (multiple-value-bind (symbol status) (find-symbol (symbol-name ',name) (find-package :html-tags))
            (unless (eql status :external)
              (export symbol (find-package :html-tags))))))

(defmacro html (&body forms)
  `(make-html-forms ,@forms))
