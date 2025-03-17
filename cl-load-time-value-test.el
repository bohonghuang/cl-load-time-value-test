;;; cl-load-time-value-test.el --- Test code for `cl-load-time-value'  -*- lexical-binding:t -*-

;; Author: Bohong Huang <bohonghuang@qq.com>
;; Maintainer: Bohong Huang <bohonghuang@qq.com>
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Code:

(require 'cl-lib)

(defvar ltvt-hook nil)

(defun ltvt-add-hook (hook function &optional depth)
  (add-hook hook function depth t))

(defun ltvt-remove-hook (hook function)
  (remove-hook hook function t))

(defun lvvt-make-hook-once (function)
  (letrec ((hook (lambda () (ltvt-remove-hook 'ltvt-hook hook) (funcall function)))) hook))

;;;###autoload
(defun ltvt-test ()
  (interactive)
  (let ((hook (cl-load-time-value (lvvt-make-hook-once (lambda () (message "Test message"))))))
    (if (member hook ltvt-hook)
        (run-hooks 'ltvt-hook)
      (ltvt-add-hook 'ltvt-hook hook))))

(provide 'cl-load-time-value-test)
;;; cl-load-time-value-test.el ends here
