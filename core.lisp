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

(define-constant *mstdn-buffer-name* "Mastodon")

(defun select-window (window)
  (setf (current-window) window))

(defun make-mstdn-buffer (name)
  (change-buffer-mode (make-buffer name) 'mstdn-mode))

(define-command mstdn-show () ()
  (let* ((buffer (make-mstdn-buffer *mstdn-buffer-name*))
         (window (display-buffer buffer)))
    (select-window window)))

(define-command mstdn-hide () ()
  (let* ((buffer (make-mstdn-buffer *mstdn-buffer-name*))
         (windows (get-buffer-windows buffer)))
    (loop for w in windows
          do (delete-window w))))

(define-command mstdn-toggle () ()
  (let* ((buffer (make-mstdn-buffer *mstdn-buffer-name*))
         (windows (get-buffer-windows buffer)))
    (if (null windows)
      (mstdn-show)
      (mstdn-hide))))
