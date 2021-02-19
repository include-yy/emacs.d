(let (
      ;; temporarily increase `gc-cons-threshold' to speed up boost
      (gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))

  ;; define some boost directories for ease of migration
  (defvar yy-emacs-root-dir (file-truename "~/yy-emacs/site-lisp"))
  (defvar yy-emacs-config-dir (concat yy-emacs-root-dir "/config"))
  (defvar yy-emacs-extension-dir (concat yy-emacs-root-dir "/extensions"))

  (with-temp-message ""
    (require 'benchmark-init-modes)
    (require 'benchmark-init)
    (benchmark-init/activate)

    (require 'init-startup)
    (require 'init-generic)
    (require 'lazy-load)
    (require 'basic-toolkit)
    (require 'redo+)

    (require 'init-line-number)
    (require 'init-dired)
    (require 'init-ido)
    (require 'init-icomplete)
    (require 'init-comment)

    ;;(require 'init-disable-mouse)
    (require 'init-hipple-exp)
    (require 'init-backup)
    (require 'init-auto-save)
    (require 'init-highlight-parentheses)
    (require 'init-smex)
    (require 'init-session)
    (require 'init-windows)

    ;;(require 'init-ivy)
    ;;(require 'init-key)

    (run-with-idle-timer
     1 nil
     #'(lambda ()
	 (require 'init-company-mode)
	 (require 'init-yasnippet)
	 (message "Hello, world")
	 ))))


(provide 'init)

;;; init.el ends here
