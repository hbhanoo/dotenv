;;; --------------------------------------------------------------------------------
;;; File: .emacs
;;; 
;;; Hemant Bhanoo
;;;
;;; --------------------------------------------------------------------------------

;; Get the big button-bar OFF if we are using xemacs
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
;;; Load in any global configuration files:
;;; 

(add-to-list 'load-path "/Users/bhanoo/.emacs.d/lisp")
(add-to-list 'load-path "/Users/bhanoo/.emacs.d/third-party")

(load-library "bhanoo.keydefs")

;; svn stuff
;;(require 'psvn)

;; git
(add-to-list 'load-path "/usr/local/share/git-core/contrib/emacs/")
(load-library "git")
(load-library "git-blame.el")

;package management:
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; packages:
;;  flymake-mode
;;  haml-mode
;;  mmm-mode (aka multiple major modes)
;;  sass-mode
;;  yaml-mode
;;  yari (ri for emacs)
;;  rvm
;;  goto-gem
;;  coffee-mode
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

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (inf-ruby-keys)
	     ))


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
(set-face-foreground 'show-paren-match-face nil) (set-face-background 'show-paren-match-face "blue")
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

(put 'narrow-to-region 'disabled nil)

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
(setq-default tab-width 2)
