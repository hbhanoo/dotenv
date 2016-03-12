;;; --------------------------------------------------------------------------------
;;; MOUSE / KEYBOARD DEFINITIONS
;;; --------------------------------------------------------------------------------

;;; Support for mouse-wheel scrolling and alt-arrow scrolling

(global-set-key '[mouse-5]       'scroll-down-in-place )
(global-set-key '[mouse-4]       'scroll-up-in-place )
(global-set-key '[(meta down)]   'scroll-down-in-place )
(global-set-key '[(meta up)]     'scroll-up-in-place )

;;; Invert the standard search functions
;;; so that regexp search is the default:

(global-set-key "\C-s"           'isearch-forward-regexp)
(global-set-key "\M-\C-s"        'isearch-forward)
(global-set-key "\C-r"           'isearch-backward-regexp)
(global-set-key "\C-\M-r"        'isearch-backward)

;;; xemacs-like Key bindings

(global-set-key '[(control return)] 'other-window)
(global-set-key '[(control meta return)] 'swap-windows)

(global-set-key "\M-g"           'goto-line)

;;; Quick access to the speedbar:
(global-set-key "\C-x\C-x"       'speedbar)
(global-set-key "\C-x\C-r"       'speedbar-refresh)

;;; Prevent overwrite mode:
(global-set-key '[insert]        nil)


;;; Quick access to buffer resizing (vertical)
(global-set-key '[(control meta up)]   'enlarge-window)
(global-set-key '[(control meta down)] 'shrink-window)

;;; Quick access to buffer resizing (horizontal)
(global-set-key '[(control meta right)]	'enlarge-window-horizontally)
(global-set-key '[(control meta left)]	'shrink-window-horizontally)

;;; Shell command insert
(global-set-key "\M-S"		'shell-command-insert)
(global-set-key '[(control meta b)]   'bury-buffer)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;;; when you change this file, M-x byte-compile-file
