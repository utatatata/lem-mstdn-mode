(defpackage :lem-mstdn-mode.core
  (:use :cl
        :lem)
  (:import-from :alexandria
                :define-constant)
  (:export :*mstdn-mode-hook*
           :mstdn-show
           :mstdn-hide
           :mstdn-toggle))
(in-package :lem-mstdn-mode.core)

(defvar *mstdn-mode-hook* '())

(define-major-mode mstdn-mode fundamental-mode
  (:name "mastodon"
   :keymap *mstdn-mode-keymap*))

(define-constant *htl-buffer-name* "Mastodon")

(defun select-window (window)
  (setf (current-window) window))

(defun make-mstdn-buffer (name)
  (change-buffer-mode (make-buffer name) 'mstdn-mode))

(defun get-htl-buffer ()
  (make-mstdn-buffer *htl-buffer-name*))

(defun get-htl-windows ()
  (get-buffer-windows (get-htl-buffer)))

(define-command mstdn-show () ()
  (select-window
   (display-buffer (get-htl-buffer))))

(define-command mstdn-hide () ()
  (loop for w in (get-htl-windows)
        do (delete-window w)))

(define-command mstdn-toggle () ()
  (let ((windows (get-htl-windows)))
    (if (null windows)
      (mstdn-show)
      (mstdn-hide))))
