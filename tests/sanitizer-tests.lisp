(in-package :cl-hctsmsl)

(in-suite sanitizer-tests)

(test simple-sanitizing
  (is (equal "Test: &lt;&#47;div&gt;"
             (sanitize "Test: </div>"))))

(test advanced-sanitizing
  (is (equal "&lt;&#47;&lt;div&gt;&#92; &amp; super &lt;&quot;&#39;&quot;&#39;&quot;&gt;&gt;"
             (sanitize "</<div>\\ & super <\"'\"'\">>"))))
