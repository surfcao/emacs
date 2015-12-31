;;; polymode.el
;; Versatile multiple modes with extensive literate programming support
;; https://github.com/vitoshka/polymode
;;
;;; R-RELATED
(use-package poly-R
  :mode (("\\.Rnw" . poly-noweb+r-mode)
         ("\\.Rmd" . poly-markdown+r-mode))
  :config
  (bind-key "C-c n" 'polymode-next-chunk-same-type     polymode-mode-map)
  (bind-key "C-c p" 'polymode-previous-chunk-same-type polymode-mode-map))
;;
;;
;;; MARKDOWN-related
(use-package poly-markdown
  :mode ("\\.md" . poly-markdown-mode))
