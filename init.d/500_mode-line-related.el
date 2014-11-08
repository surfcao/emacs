;;; Mode-line-related


;;;
;;; powerline.el
;; https://github.com/milkypostman/powerline
;; http://shibayu36.hatenablog.com/entry/2014/02/11/160945
(require 'powerline)
;;
;; https://github.com/shibayu36/emacs/blob/8376ba4e4b4d5cb4668e848c9a494b287232ea6f/emacs.d/inits/01-mode-line.el
(set-face-attribute 'mode-line nil
                    :foreground "black"
                    :background "gray90"
                    :box nil)
(set-face-attribute 'powerline-active1 nil
                    :foreground "black"
                    :background "gray80"
                    :inherit 'mode-line)
(set-face-attribute 'powerline-active2 nil
                    :foreground "black"
                    :background "gray70"
                    :inherit 'mode-line)
;;
;; Configure at the end
(powerline-default-theme)
;;
;; https://github.com/shibayu36/emacs/blob/8376ba4e4b4d5cb4668e848c9a494b287232ea6f/emacs.d/inits/01-mode-line.el
(defvar mode-line-cleaner-alist
  '(;; For minor-mode, first char is 'space'
    (flymake-mode . " Fm")
    (paredit-mode . " pr")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . "")
    (git-gutter-mode . "")
    (anzu-mode . "")
    (yas-minor-mode . "")
    (guide-key-mode . "")
    (icicle-mode . "")
    (magit-auto-revert . "")
    (elisp-slime-nav-mode . "")
    ;;
    ;; Major modes
    (dired-mode . "Dir")
    (emacs-lisp-mode . "el")
    ))
;;
(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))
;;
(add-hook 'after-change-major-mode-hook 'clean-mode-line)



;; ;;;
;; ;;; smart-mode-line.el		; A color coded smart mode-line.
;; ;; https://github.com/Bruce-Connor/smart-mode-line/
;; ;; https://github.com/Bruce-Connor/smart-mode-line/blob/master/smart-mode-line.el
;; ;;
;; ;; ALL COLORS ARE CUSTOMIZABLE! M-x sml/customize-faces
;; ;;
;; ;; Theme: 'automatic, 'respectful, 'dark, 'light or nil
;; ;; To change while in session use: M-x sml/apply-theme
;; (setq sml/theme nil)
;; ;;
;; ;; Load
;; (require 'smart-mode-line)
;; (sml/setup)
;; ;;
;; ;; cutom background colors
;; ;; (setq sml/inactive-background-color "gray55")
;; ;; (setq sml/active-background-color   "gray80")
;; ;;
;; ;; https://github.com/mgalgs/.emacs.d/blob/master/smart-mode-line-setup.el
;; ;;
;; ;; When the buffer+directory name is longer than
;; ;; `sml/name-width':
;; ;; 	if nil the rest of the mode-line is pushed right;
;; ;; 	otherwise the directory name is shortened to fit.
;; (setq sml/name-width 15)
;; (setq sml/shorten-directory t)
;; ;;
;; ;; When the modes list is longer than `sml/mode-width':
;; ;; 	if nil the rest of the mode-line is pushed right;
;; ;; 	otherwise the list is shortened to fit.
;; ;; (setq sml/mode-width 'full)
;; (setq sml/mode-width 15)
;; (setq sml/shorten-modes t)
;; ;;
;; ;; modes to hide
;; (add-to-list 'sml/hidden-modes " ICY")
;; (add-to-list 'sml/hidden-modes " Icy")
;; (add-to-list 'sml/hidden-modes " SliNav")
;; (add-to-list 'sml/hidden-modes " yas")
;; (add-to-list 'sml/hidden-modes " Projectile")
;; (add-to-list 'sml/hidden-modes " AC")
;; (add-to-list 'sml/hidden-modes " Paredit")
;; (add-to-list 'sml/hidden-modes " ARev")
;; (add-to-list 'sml/hidden-modes " MRev")
;; (add-to-list 'sml/hidden-modes " [none]")	; Projectile
;; (add-to-list 'sml/hidden-modes " View")
;; ;;
;; ;;  3. `sml/replacer-regexp-list'
;; ;;   This variable is a list of (REGEXP REPLACEMENT) that is used
;; ;;   to parse the path. The replacements are applied
;; ;; Here go some more useful examples:
;; ;;
;; ;;     (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/Projects/In-Development/" ":ProjDev:"))
;; ;;     (add-to-list 'sml/replacer-regexp-list '("^~/Documents/Work/" ":Work:"))
;; ;;
;; ;;     ;; Added in the right order, they even work sequentially:
;; ;;     (add-to-list 'sml/replacer-regexp-list '("^:DB:Documents" ":DDocs:"))
;; ;;     (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/" ":DB:"))
;; ;;     (add-to-list 'sml/replacer-regexp-list '("^:Git:\\(.*\\)/src/main/java/" ":G/\\1/SMJ:"))
;; ;;     (add-to-list 'sml/replacer-regexp-list '("^~/Git-Projects/" ":Git:"))