;;; SHELL ENVIRONMENT-RELATED

;;;
;;; shell scripts saved with chmod +x
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)


;;;
;;; exec-path-from-shell.el to configure correct $PATH for external files
;; https://github.com/purcell/exec-path-from-shell
;; http://d.hatena.ne.jp/syohex/20130718/1374154709
;; http://qiita.com/catatsuy/items/3dda714f4c60c435bb25#1-1
;; check with (getenv "PATH")
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))


;;;
;;; shell-command.el
;; bash-completion in emacs' shell (M-x shell)
;; http://stackoverflow.com/questions/163591/bash-autocompletion-in-emacs-shell-mode
;; https://github.com/szermatt/emacs-bash-completion
;; http://www.namazu.org/~tsuchiya/elisp/shell-command.el
(use-package shell-command
  :commands (shell-command-completion-mode)
  :config
  (add-hook 'shell-dynamic-complete-functions
            'bash-completion-dynamic-complete)
  (add-hook 'shell-command-complete-functions
            'bash-completion-dynamic-complete))
(add-hook 'shell-mode-hook 'shell-command-completion-mode)



;;;
;;; multi-term.el
;; rubikitch book p199
(use-package multi-term
  :commands (multi-term)
  :config
  (setq multi-term-program "/bin/bash")
  ;; Key not used by term
  (setq term-unbind-key-list '("C-x" "C-c" "<ESC>"))
  ;; Assign these commands (part of what is in the definition file).
  (setq term-bind-key-alist
        '(("C-c C-c" . term-interrupt-subjob)
          ("C-m" . term-send-raw)
          ("M-f" . term-send-forward-word)
          ("M-b" . term-send-backward-word)
          ("M-o" . term-send-backspace)
          ("M-p" . term-send-up)
          ("M-n" . term-send-down)
          ("M-M" . term-send-forward-kill-word)
          ("M-N" . term-send-backward-kill-word)
          ("M-r" . term-send-reverse-search-history)
          ("M-," . term-send-input)
          ("M-." . comint-dynamic-complete))))



;;;
;;; flymake-shell.el 2013-12-27
;; https://github.com/purcell/flymake-easy
(use-package flymake-shell
  :commands (flymake-shell-load))
(add-hook 'sh-set-shell-hook 'flymake-shell-load)


;;;
;;; SSH support
;;
;; Passphrase issue in OS X. Conflict with gpg-agent
;; How to pass the user-agent ssh key passphrase through to Emacs [i.e. for magit]?
;; https://www.reddit.com/r/emacs/comments/3skh5v/how_to_pass_the_useragent_ssh_key_passphrase/
;; SSH_AUTH_SOCK must be setenv'ed correctly in OS X. However, gpg-agent overrides this.
;; my-set-gpg-agent-info was the offender. Do not use if gpg-agent is not acting as ssh-agent.
;;
;; Code to fix SSH_AUTH_SOCK back to OS X-native
;; (when (eq system-type 'darwin)
;;   (setenv "SSH_AUTH_SOCK"
;;           (replace-regexp-in-string "\n$" ""
;;                                     (shell-command-to-string "ls /private/tmp/*launchd*/Listeners"))))
;;
;;
;;; ssh.el
;; M-x ssh to run remote shell
;; https://github.com/ieure/ssh-el
;; http://www.emacswiki.org/emacs/ShellDirtrackByPrompt
(use-package ssh
  :commands (ssh)
  :config
  (setq ssh-directory-tracking-mode 'ftp)
  ;;
  (add-hook 'ssh-mode-hook
            (lambda ()
              (shell-dirtrack-mode t)
              (setq dirtrackp nil))))


;;;
;;; TRAMP (Transparent Remote Access, Multiple Protocols) 2014-01-17
;; Access remote files like local files
;; http://www.emacswiki.org/emacs/TrampMode
;; http://www.gnu.org/software/tramp/#Configuration
(require 'tramp)
;; This is faster.
(setq tramp-default-method "ssh")
;;
;; Respect locally set path
;; http://emacs.stackexchange.com/questions/7673/how-do-i-make-trampeshell-use-my-environment-customized-in-the-remote-bash-p
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
;;
;; Never use inline copying to avoid “invalid base64 data” error
;; http://emacs.stackexchange.com/questions/22304/invalid-base64-data-error-when-using-tramp
(setq tramp-copy-size-limit nil)
;;
;; Handle Odyssey's two-step authentication. Password:, then, Verification code:   2014-01-18
;; http://emacs.1067599.n5.nabble.com/emacs-hangs-when-connecting-from-windows-to-linux-with-tcsh-shell-td244075.html
;; (setq tramp-password-prompt-regexp "^.*\\([pP]assword\\|[pP]assphrase\\).*: ? *")	; Original
(setq tramp-password-prompt-regexp "^.*\\([pP]assword\\|[pP]assphrase\\|Verification code\\).*: ? *")
;;
;; Completion works in the eshell open from within a tramp connection
;; http://stackoverflow.com/questions/1346688/ssh-through-emacs-shell
;;
;; /sudo:hostname for sudo'ing after remote login
;; http://qiita.com/miyakou1982/items/d05e1ce07ad632c94720
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '("localhost" nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))



;;;
;;; Open in Terminal app
;; http://truongtx.me/2013/09/13/emacs-dired-new-terminal-window-at-current-directory-on-macos/
;; default terminal application path
(defvar osx-term-app-path
  "/Applications/Utilities/Terminal.app"
  "The path to the terminal application to use in open-in-osx-term-app")
;;
;; function to open new terminal window at current directory
(defun open-in-osx-term-app ()
  "Open current directory in dired mode in terminal application.
For OS X only"
  (interactive)
  (shell-command (concat "open -a "
                         (shell-quote-argument osx-term-app-path)
                         " "
                         (shell-quote-argument (file-truename default-directory)))))
;;
(global-set-key (kbd "C-c t") 'open-in-osx-term-app)



;;;
;;; Gnu Privacy Guard (gpg)-related
;;
;;; gpg-agent handling
;; http://whatthefuck.computer/blog/2015/05/20/re-agent/
(defun my-set-gpg-agent-info ()
  "Load your gpg-agent.env file in to the environment

SSH_AUTH_SOCK and SSH_AGENT_PID are updated for gpg-agent.
This is extra useful if you use gpg-agent with --enable-ssh-support
Do not use if gpg-agent is not acting as ssh-agent. It will break
OS X-native SSH_AUTH_SOCK."
  (interactive)
  (let ((home (getenv "HOME"))
        (old-buffer (current-buffer)))
    (with-temp-buffer
      (insert-file-contents (concat home "/.gpg-agent-info"))
      (goto-char (point-min))
      (setq case-replace nil)
      (replace-regexp "\\(.*\\)=\\(.*\\)" "(setenv \"\\1\" \"\\2\")")
      (eval-buffer)))
  (getenv "GPG_AGENT_INFO"))
;;
;; Incompatible with current OS X-naitive SSH_AUTH_SOCK
;; ;; Retrieve and set GPG_AGENT_INFO
;; (my-set-gpg-agent-info)
;; ;; Repeat when idle for 60 sec
;; (run-with-idle-timer 60 t 'my-set-gpg-agent-info)
