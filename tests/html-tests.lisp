(in-package #:cl-hctsmsl)

(in-suite html-tests)

(test inline-form-generation
  (is (equal (format nil "<h1>test</h1>~%")
             (html (<:h1 "test")))))

(test block-form-generation
  (is (equal (format nil "<p>~%~4Ttest~%~4Ttest~%</p>~%")
             (html (<:p "test" "test")))))

(test multilevel-form-generation
  (is (equal (format nil "<div>~%~4T<p>~%~8Ttest~%~8Ttest~%~4T</p>~%~4Thelloworld~%</div>~%")
             (html (<:div (<:p "test" "test") "helloworld")))))

(test list-parameters
  (is (equal (format nil "<div class=\"a b c\" align=\"left\">~%~4Ttest~%</div>~%")
             (html (<:div '(:class (:a :b :c) :align :left) "test")))))

(test sanitize-contents
  (is (equal (format nil "<div>~%~4T&lt;&gt;&amp;&#92;&quot;~%</div>~%")
             (html (<:div () "<>&\\\"")))))

(test comment-generation
  (is (equal (format nil "<!-- LOLD SO HARD, MAN -->~%")
             (html (<:comment "LOLD" "SO" "HARD," "MAN")))))

(test doctype-generation
  (is (equal (format nil "<!DOCTYPE html>~%")
             (html (<:doctype :html)))))
