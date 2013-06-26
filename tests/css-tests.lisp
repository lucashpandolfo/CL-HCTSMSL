(in-package #:cl-hctsmsl)

(in-suite css-tests)

(test element-selector
  (is (equal (format nil "h1 {~%~4Tcolor: red;~%}")
             (css (:element :h1) (:color "red")))))

(test class-selector
  (is (equal (format nil ".red {~%~4Tcolor: red;~%}")
             (css (:class :red) (:color "red")))))

(test id-selector
  (is (equal (format nil "#red {~%~4Tcolor: red;~%}")
             (css (:id :red) (:color "red")))))

(test attribute-selector
  (is (equal (format nil "[color=\"red\"] {~%~4Tcolor: red;~%}")
             (css (:attribute (nil :color "red"))
               (:color "red")))))

(test parent-selector
  (is (equal (format nil "h1#red h2.red {~%~4Tcolor: green;~%}")
             (css (:parent (:id :h1 "red") (:class :h2 "red"))
               (:color "green")))))

(test child-selector
  (is (equal (format nil "h1 > h2 > h3 {~%~4Tcolor: green;~%}")
             (css (:child :h1 :h2 :h3) (:color "green"))))
  (is (equal (format nil "h1.red > h2#green {~%~4Tcolor: green;~%}")
             (css (:child (:class :h1 "red") (:id :h2 "green"))
               (:color "green")))))

(test after-selector
  (is (equal (format nil "h1 + h2 + h3 {~%~4Tcolor: green;~%}")
             (css (:after :h1 :h2 :h3) (:color "green"))))
  (is (equal (format nil "h1.red + h2#green {~%~4Tcolor: green;~%}")
             (css (:after (:class :h1 "red") (:id :h2 "green")) 
               (:color "green"))))) 

(test pseudoclass-selector
  (is (equal (format nil "h1:hoover {~%~4Tcolor: red;~%}")
             (css (:pseudoclass (:h1 "hoover")) (:color "red")))))

(test pseudoelt-selector
  (is (equal (format nil "div::first-line {~%~4Tcolor: red;~%}")
             (css (:pseudoelt (:div "first-line")) (:color "red")))))
