;;; Markdown mode
;; http://jblevins.org/projects/markdown-mode/
;;
(use-package markdown-mode
  :mode ("\\.md" . markdown-mode)
  :config
;;; Open current file in Atom for real-time preview
  ;; http://qiita.com/takuma510/items/77489cf538580dfcc41d
  (defun open-atom ()
    (interactive)
    (call-process
     "atom" nil nil nil buffer-file-name)))


;;; Graphviz mode
;; http://ppareit.github.io/graphviz-dot-mode/
(use-package graphviz-dot-mode
  :mode ("\\.dot" . graphviz-dot-mode))
;; Font locking is automatic, indentation uses the same commands as
;; other modes, tab, M-j and C-M-q.  Insertion of comments uses the
;; same commands as other modes, M-; .  You can compile a file using
;; M-x compile or C-c c, after that M-x next-error will also work.
;; There is support for viewing an generated image with C-c p.
