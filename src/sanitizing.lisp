(in-package :cl-hctsmsl)

(defparameter *default-escaping-rules*
  '((#\< . "&lt;")
    (#\> . "&gt;")
    (#\" . "&quot;")
    (#\# . "&#35;")
    (#\& . "&amp;")
    (#\' . "&#39;")
    (#\/ . "&#47;")
    (#\\ . "&#92;"))
  "List of characters that could lead us to some problems therefore they should be replaced by safer alternatives (aka escape characters).")

(defun get-replacement-for-character (char &optional (rules *default-escaping-rules*))
  (cdr (assoc char rules
              :test #'equal)))

(defun sanitize (string &optional (rules *default-escaping-rules*))
  (with-output-to-string (result)
    (loop for char across string
          for replacement = (get-replacement-for-character char rules)
          if replacement
            do (princ replacement result)
          else
            do (princ char result))))
