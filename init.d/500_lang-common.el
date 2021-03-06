;;; 500_lang-common.el ---                           -*- lexical-binding: t; -*-
;; Settings useful for programming in general

;;;
;;; electric-spacing.el
;; https://github.com/zk-phi/electric-spacing
(use-package electric-spacing
  :disabled t)


;;;
;;; column-marker.el
;; http://www.emacswiki.org/emacs/column-marker.el
(use-package column-marker
  :commands column-marker80
  :config
  (defun column-marker80 ()
    (interactive)
    (column-marker-2 80)))


;;;
;;; aggressive-indent.el
;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :commands (aggressive-indent-mode))
(add-hook 'emacs-lisp-mode-hook 'aggressive-indent-mode)


;;;
;;; dumb-jump.el
;; https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :disabled t
  :config
  (dumb-jump-mode))
