;;;
;;; General
;;;
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq-default display-time-24hr-format t)
(display-time)
(setq ring-bell-function 'ignore)      ; Disable bell
(setq make-backup-files nil)           ; No backup files
(show-paren-mode 1)                    ; Show Paren Mode
(require 'dired-x)                     ; C-x C-j dired-jump
(setq-default global-font-lock-mode t) ; turn on syntax highlighting
(setq-default fill-column 80)          ; wrap at 80
(setq-default show-trailing-whitespace t)
(mouse-avoidance-mode 'animate)
(setq-default indent-tabs-mode nil)    ; indent with spaces
(fset 'yes-or-no-p 'y-or-n-p)          ; replace yes/no with y/n
(setq-default remote-shell-program "ssh")
(global-auto-revert-mode 1)            ; revert files changed on disk
(setq echo-keystrokes 0.1)
(setq inhibit-startup-message t)
(set-cursor-color "#ff8c00")

(setq evil-want-C-u-scroll t)          ; Ctrl-u to scroll up

(when (string-match "apple-darwin" system-configuration)
  (setq mac-allow-anti-aliasing t))

; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

;;;
;;; package
;;;
(require 'package)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;;;
;;; el-get
;;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))
(setq my-packages (append '(
                            clojure-mode
                            coffee-mode
                            el-get
                            evil
                            paredit
                            rainbow-delimiters
                            )))
(el-get 'sync my-packages)

;;;
;;; evil
;;;
(evil-mode 1)

; map jk to ESC
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?k)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?k))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))

;;;
;;; clojure
;;;
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

;;;
;;; org
;;;
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;;;
;;; theme
;;;
(set-default-font "Inconsolata-14")
(add-to-list 'custom-theme-load-path
         "~/.emacs.d/custom/tomorrow-theme/GNU Emacs")
(load-theme 'tomorrow-night t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

