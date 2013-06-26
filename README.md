CL-HCTSMSL
===========

CL-HCTSMSL is for HTML+CSS=HcTsMsL, see?  
This is simple Lisp to HTML and CSS compiler.  
Currently I'm working on JS support.  
Why do I do this? The answer is: "Why not?".  


Usage
======

Currently it supports not much HTML tags.  
All available expressions are in src/html-ops.lisp file.  
You can expand this list if you want.


HTML
----

HTML expressions use this syntax:
```lisp
(html (<:tag '(:attribute "value" :id "some-id" and so on) some arguments))
```
or
```lisp
(html '(<:tag some arguments))
```
Both variants are syntactically correct.

Here's an example of usage:
```lisp
(html (<:div (<:h1 "Winwin") (<:p "Hello!" "Hello again!"))) =>
"<div>
    <h1>Winwin</h1>
    <p>
        Hello!
        Hello again!
    </p>
</div>"
```

As you can see, it automatically defines which way of formatting code it should use.
You can, however, force this mode manually by specifying it in tag definition (see html-ops.lisp).
I'm working on a way to allow specifying it in code so keep your local copy up-to-date.

It also supports comments and doctype
```lisp
(html (<:comment "this is a test comment")) =>
"<!-- this is a test comment -->"

(html (<:doctype :html)) =>
"<!DOCTYPE html>"
```

It even supports every HTML tag attribute!
```lisp
(html (<:div '(:class "red") "Hello, World!")) =>
"<div class=\"red\"
    Hello, World!
</div>"

(html (<:h1 '(:id "title" :class "title") "TITLE")) =>
"<h1 id=\"title\" class=\"title\">TITLE</h1>"

(html (<:h1 '(:lol "value") "TEST")) =>
"<h1 lol=\"value\">TEST</h1>"
```

CSS
---

CSS expressions use almost the same syntax:
```lisp
(css ((:selector-type some-arguments) (:parameter "value") (:color "red")))
```

Here's an example:
```lisp
(css ((:element :h1 :h2) (:color "red") (:text-align "center"))) =>
"h1 h2 {
    color: red;
    text-align: center;
}"
```

Different selector types have different syntax:
* element     -> (:element tag-1 tag-2) => tag-1 tag-2
* class       -> (:class class-1 class-2) => .class-1 .class-2
* id          -> (:id id-1 id-2) => #id-1 #id2
* attribute   -> (:attribute (tag :color "red")) => tag[color="red"] ; If tag is NIL, it leaves tag blank.
* parent      -> (:parent (:id "tag" "id") (:class "tag-2" "class")) => tag#id tag-2.class
* child       -> (:child (:id :h1 "id") (:class h2 "class") h3) => h1#id > h2.class > h3
* after       -> (:child (:id :h1 "id") (:class h2 "class") h3) => h1#id + h2.class + h3
* pseudoclass -> (:pseudoclass (:a "hoover")) => a:hoover
* pseudoelt   -> (:pseudoelt (:div "first-line")) => div::first-line


JS
---

TODO


P.S.
-----

To be clear, I need to notice that it adds newline character after the last line in output.  
I've removed it because it is not necessary to show how it works.
