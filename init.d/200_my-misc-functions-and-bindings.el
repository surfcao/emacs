;;; My miscellaneous functions -*- lexical-binding: t; -*-

;;;
;;; Take current line to top
(defun my-recenter-top ()
  "Recenter to the top"
  (interactive)
  (recenter "Top"))
(global-set-key (kbd "C-S-l") 'my-recenter-top)


;;;
;;; my-insert-date
;; http://ergoemacs.org/emacs/elisp_datetime.html
(defun my-insert-date ()
  "Insert current date yyyy-mm-dd."
  (interactive)
  (when (region-active-p)
    (delete-region (region-beginning) (region-end)))
  (insert (format-time-string "%Y-%m-%d")))
(global-set-key (kbd "C-c d") 'my-insert-date)


;;;
;;; replace (kbd "C-c r")
(global-set-key (kbd "C-c r") 'replace-string)


;;;
;;; Surround region
;; http://www.emacswiki.org/emacs/SurroundRegion
(defun surround (begin end open close)
  "Put OPEN at START and CLOSE at END of the region.
If you omit CLOSE, it will reuse OPEN."
  (interactive  "r\nsStart: \nsEnd: ")
  (when (string= close "")
    (setq close open))
  (save-excursion
    (goto-char end)
    (insert close)
    (goto-char begin)
    (insert open)))


;;;
;;; flush-empty-lines
(defun flush-empty-lines (start end)
  "Flush empty lines in the selected region."
  (interactive "r")
  ;; Do not do anything if no selection is present.
  (if (and transient-mark-mode mark-active)
      (flush-lines "^ *$" start end)))
;; key
(global-set-key (kbd "s-f") 'flush-empty-lines)