(defpackage #:uf/builtin/define
  (:use #:cl #:uf/reader #:uf/stack #:uf/vm)
  (:export #:*initial-word-list*
           #:defword))
(in-package #:uf/builtin/define)

(defparameter *initial-word-list* nil)

(defmacro defword ((name immediate? data) exec-code &optional comp-code init-code)
  (let (($vm (gensym "defw/vm")))
    `(push (lambda (,$vm)
             (add-builtin-word ,$vm ,name ,immediate? ,data
                               (lambda (vm word parent)
                                 (declare (ignorable vm word parent)) ,init-code)
                               (lambda (vm word parent)
                                 (declare (ignorable vm word parent)) ,comp-code)
                               (lambda (vm word parent)
                                 (declare (ignorable vm word parent)) ,exec-code)))
           uf/builtin/define:*initial-word-list*)))
