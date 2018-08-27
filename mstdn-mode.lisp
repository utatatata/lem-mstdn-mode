(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :lem-mstdn-mode)
    (defpackage :lem-mstdn-mode
      (:use :cl
            :lem
            :lem-mstdn-mode.core)
      (:export :*mstdn-mode-hook*
               :mstdn-show
               :mstdn-hide
               :mstdn-toggle))))

