;;; --------------------------------------------------------------------------------
;;; File: .emacs
;;;
;;; Hemant Bhanoo
;;;
;;; --------------------------------------------------------------------------------

;;; from https://www.emacswiki.org/emacs-test/LoadingLispFiles

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(defmacro with-library (symbol &rest body)
	`(condition-case nil
			 (progn
				 (require ',symbol)
				 ,@body)

		 (error (message (format "I guess we don't have %s available." ',symbol))
						nil)))
(put 'with-library 'lisp-indent-function 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Get the big button-bar OFF if we are using xemacs
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
;;; Load in any global configuration files:
;;;

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/third-party")

(load-library "bhanoo.keydefs")
(load-library "web-mode.el")
(require 'web-mode)
(defun my-web-mode-hook ()
  "Indentation hook for web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-ruby-rubocop-executable "/Users/hbhanoo/.rbenv/shims/rubocop")
 '(package-selected-packages
   '(tide lsp-mode find-file-in-project find-file-in-repository lua-mode typescript typescript-mode adoc-mode flymd logview sort-words jsx-mode less-css-mode web-mode s yaml-mode hamlet-mode sass-mode flymake-mode mmm-mode haml-mode lsp-mode tide)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; from https://www.emacswiki.org/emacs-test/LoadingLispFiles
(defmacro with-library (symbol &rest body)
	`(condition-case nil
			 (progn
				 (require ',symbol)
				 ,@body)

		 (error (message (format "I guess we don't have %s available." ',symbol))
						nil)))
(put 'with-library 'lisp-indent-function 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Get the big button-bar OFF if we are using xemacs
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
;;; Load in any global configuration files:
;;;
;package management:
(require 'package)
; list the packages you want
(setq package-list '(haml-mode mmm-mode sass-mode yaml-mode yari rvm goto-gem coffee-mode markdown-mode markdown-preview-mode find-file-in-repository))
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
; activate all the packages (in particular autoloads)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'flymake-ruby)

(require 's)
(require 'rvm)
;; make ruby indentation normal
(setq ruby-deep-indent-paren nil)

; bhanoo 2015/11/17 this is not working anymore
;; Set up some ruby shizat
;(load-file "/opt/local/lib/ruby/elisp/ruby-mode.el")
;(load-file "/opt/local/lib/ruby/elisp/inf-ruby.el")
;(setq ri-ruby-script "/opt/local/lib/ruby/elisp/ri-emacs.rb")
;(autoload 'ri "/opt/local/lib/ruby/elisp/ri-ruby.el" nil t)

;; (autoload 'run-ruby "inf-ruby"
;;   "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;   "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook
;; 	  '(lambda ()
;; 	     (inf-ruby-keys)
;; 	     ))

(global-set-key (kbd "C-x f") 'find-file-in-repository)


(defun scroll-down-in-place (arg)
  "like next-line but window moves, cursor stands still; with arg=n, n lines"
  (interactive "P")
  (if (not arg)
      (setq arg 1))
  (scroll-up arg)
;;;  (next-line arg) ;;;---this causes the cursor to move with the scrolling
  )

(defun scroll-up-in-place (arg)
  "like next-line but window moves, cursor stands still; with arg=n, n lines"
  (interactive "P")
  (if (not arg)
      (setq arg 1))
  (scroll-down arg)
;;;  (previous-line arg);;;---this causes the cursor to move with the scrolling
  )

(defun swap-windows (&optional swap-cursor)
 "swap left and right or top and bottom windows -- useful to make
things appear in an appropriate orientation"
 (interactive)
 (let* (
    (buf1 (buffer-name))
    (buf2 nil)
    )
   (other-window 1)
   (setq buf2 (buffer-name))
   (message (concat buf1 " <=> " buf2))
   (switch-to-buffer buf1)
   (other-window 1)
   (switch-to-buffer buf2)
   (if swap-cursor
   (other-window 1))
   )
 )

(require 'icomplete)
(icomplete-mode)
(require 'paren)
(show-paren-mode 't)
(setq show-paren-style 'mixed)
;; ERROR 2021/12/24 (set-face-foreground 'show-paren-match-face nil) (set-face-background 'show-paren-match-face "blue")
;;;(resize-minibuffer-mode)		; this is cool
(setq resize-minibuffer-window-max-height 5)
(global-font-lock-mode t)
;;;(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-decoration 2)

(setq auto-mode-alist (cons '("\\.c$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xs$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cfg$" . perl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pm$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))

;;; So I *hate* it when emacs automatically inserts newlines for you -
;;; it just dirties the buffer unneccessarily (sp?). This gets rid of it:
(setq next-line-add-newlines nil)


;;;********************************************************************************
;;; Hemant's Helpful Info:
;;;                     :
;;; Description
;;; Set a Key Binding   : (global-set-key "key" (func) )
;;;
;;;********************************************************************************


;;; don't blink!
(if (fboundp 'blink-cursor-mode)
    (blink-cursor-mode nil))

(defun time-insert (arg)
  "insert time-stamp"
  (interactive "P")
  ( date-insert "%Y/%m/%d:%H%M" )
  )

(defun date-insert (arg)
  "insert date format [ (arg) ]at current cursor pos. default format: %Y/%m/%d"
  (interactive "P")
  (if (not arg)
      (setq arg "%Y/%m/%d"))
  ( let ( ( command ( concat "date +" arg ) )
	  )
    ( insert-string
      ( concat "[" ( concat
		     ( substring ( shell-command-to-string command ) 0 -1 ) "]" ) )
      )
    )
)

(defun shell-command-insert (command)
  "insert results of shell command into buffer"
  (interactive "Mcommand: ")
  (insert-string
   (substring (shell-command-to-string command) 0 -1)) ; strip newline?
  )

;;; Allow files to be stored with timestamps:
(add-hook 'write-file-hooks 'time-stamp)

(defun cdshell()
  (interactive)
  (let (
	(shell-dir (shell-quote-argument default-directory))
	)
    (shell)
    (end-of-buffer)
    (insert "cd ")
    (insert shell-dir)
    (comint-send-input)
    )
)
(defalias 'shellcd 'cdshell)

;;; some mmm mode shite, good for erb:
(require 'mmm-mode)
(require 'mmm-auto)
;;;(require 'javascript-mode)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)
(set-face-background 'mmm-output-submode-face  "DarkGreen")
(set-face-background 'mmm-code-submode-face    "LightGray")
(set-face-background 'mmm-comment-submode-face "Blue")
(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :match-face (("<%#" . mmm-comment-submode-face)
                 ("<%=" . mmm-output-submode-face)
                 ("<%"  . mmm-code-submode-face))
    :front "<%[#=]?"
    :back "%>"
    :insert ((?% erb-code       nil @ "<%"  @ " " _ " " @ "%>" @)
             (?# erb-comment    nil @ "<%#" @ " " _ " " @ "%>" @)
             (?= erb-expression nil @ "<%=" @ " " _ " " @ "%>" @))
    )))
(add-hook 'html-mode-hook
          (lambda ()
            (setq mmm-classes '(erb-code))
            (mmm-mode-on)))
(add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))
(global-set-key [f8] 'mmm-parse-buffer)
(setq-default indent-tabs-mode nil) ;; no tabs please
(setq-default tab-width 2)
(setq shell-file-name "bash")
(setq shell-command-switch "-ic")
(put 'narrow-to-region 'disabled nil)
(ido-mode)

;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html
(require 'flycheck)
;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; http://www.flycheck.org/manual/latest/index.html
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; https://github.com/ananthakumaran/tide
;(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "GEM_PATH")

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)
;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; /END -- http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

;;; javascript
(setq js-indent-level 2)

;;; for jsx stuff:
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

(defun web-mode-init-hook ()
  "Hooks for Web mode.  Adjust indent."
  (setq web-mode-markup-indent-offset 2))

(add-hook 'web-mode-hook  'web-mode-init-hook)
;;; /jsx

(server-start)
(put 'upcase-region 'disabled nil)
