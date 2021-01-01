;;; init-elpa.el --- Settings and helpers for package.el
;;; -*- coding: utf-8; lexical-binding: t; -*-
;;; Comment:

;;; Code:

(require 'package)
(require 'cl-lib)

;;Install into separate package dirs for each Emacs version, to prevent bytecode incompatibility
(setq package-user-dir
      (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
			user-emacs-directory))

;;package repositories
(setq package-archives
      '(
        ;; uncomment below line if you need use GNU ELPA
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
        ;;("melpa" . "https://melpa.org/packages/")
        ;;("melpa-stable" . "https://stable.melpa.org/packages/")

        ;; Use either 163 or tsinghua mirror repository when official melpa
        ;; is slow or shutdown.

        ;; ;; {{ Option 1: 163 mirror repository:
        ;; ;; ("gnu" . "https://mirrors.163.com/elpa/gnu/")
        ("melpa" . "https://mirrors.163.com/elpa/melpa/")
        ("melpa-stable" . "https://mirrors.163.com/elpa/melpa-stable/")
        ;; ;; }}

        ;; ;; {{ Option 2: tsinghua mirror repository
        ;; ;; @see https://mirror.tuna.tsinghua.edu.cn/help/elpa/ on usage:
        ;; ;; ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ;; }}

	;; ;; {{ Option 3: emacs-china mirror repository
	;; ;; ("gnu" . "http://elpa.emacs-china.org/gnu/")
	;; ("melpa" . "http://elpa.emacs-china.org/melpa/")
	;; ("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
        ))

(defun require-package (package &optional min-version no-refresh)
  "ask elpa to install package"
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
	     (versions (mapcar #'package-desc-version known)))
	(if (cl-some (lambda (v) (version-list-<= min-version v)) versions)
	    (package-install package)
	  (if no-refresh
	      (error "No version of %s >= %S is available" package min-version)
	    (package-refresh-contents)
	    (require-package package min-version t))))))

(defun maybe-require-package (package &optional min-version no-refresh)
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

;;;Fire up package.el
(setq package-enable-at-startup nil)
(package-initialize)

;;-----------------------------------------------------------------------------
;; The installed packages
;;-----------------------------------------------------------------------------
(require-package 'evil)
(require-package 'ace-window)
(require-package 'winum)
(require-package 'smex)

(provide 'init-elpa)
;;; init-elpa.el ends here
