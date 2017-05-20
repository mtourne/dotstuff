;; confirm before killing
(setq confirm-kill-emacs 'y-or-n-p)

;; start server
(server-start)

;; Emacs Load Path
(add-to-list 'load-path "~/emacs")
;; theme load path
(add-to-list 'custom-theme-load-path "~/emacs")

;; create a backup file directory
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

;; turn off annoying bell
(setq ring-bell-function 'ignore)

;;; el-get stuff
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

; list all packages you want installed
(setq my-el-get-packages
      '(yaml-mode web-mode undo-tree package
                  markdown-mode helm-swoop helm goto-chg
                  git-modes projectile f s pkg-info epl el-get
                  magit dash color-theme auto-complete popup cl-lib fuzzy
                  lua-mode ample-regexps ace-jump-mode ace-window
                  ac-helm helm-projectile
                  rjsx-mode js2-mode
		  autopair
                  expand-region ;github version seems bork
                  ))

;; automatically reinstall
(el-get 'sync my-el-get-packages)

;;; ELPA ;;;
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;;;; Regions ;;;;
;; Note (mtourne): puting expand-region high in the conf seems
;; to have fixed it
;; expand semantic region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;;; Emacs Faces ;;;;
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Remove splash screen
(setq inhibit-splash-screen t)

;;; Color Theme
;; old one
(require 'color-theme)
(color-theme-initialize)
(require 'color-theme-tango)
(color-theme-tango)
;; new one
;(load-theme 'tangotango t)

;; invert face (colore theme is better)
;(invert-face 'default)

;; Config (generated)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(js2-basic-offset 2)
 '(mouse-wheel-mode t)
 '(package-selected-packages (quote (rjsx-mode iy-go-to-char)))
 '(safe-local-variable-values (quote ((py-indent-offset . 4))))
 '(show-paren-mode t)
 '(tab-stop-list
   (quote
    (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify)))

;;; Ido completion ;;; deprecated for helm.

;;; iswitchb
;; deprec
;; (iswitchb-mode t)
;; prevent switching to other frame when picking buffer
; (setq iswitchb-default-method 'samewindow)
;;; ido

;; (ido-mode t)
;; (setq ido-enable-flex-matching t)
;; ;; Display ido results vertically, rather than horizontally
;; ;;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;; ;;(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; ;;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
;; ;;  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
;; ;;    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
;; ;;    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
;; ;;  (add-hook 'ido-setup-hook 'ido-define-keys)
;;
;; ;; sort ido filelist by mtime instead of alphabetically
;; (add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
;; (add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
;; (defun ido-sort-mtime ()
;;   (setq ido-temp-list
;; 	(sort ido-temp-list
;; 	      (lambda (a b)
;; 		(time-less-p
;; 		 (sixth (file-attributes (concat ido-current-directory b)))
;; 		 (sixth (file-attributes (concat ido-current-directory a)))))))
;;   (ido-to-end  ;; move . files to end (again)
;;    (delq nil (mapcar
;; 	      (lambda (x) (and (char-equal (string-to-char x) ?.) x))
;; 	      ido-temp-list))))
;;

(require 'helm)
(require 'helm-config)
(require 'helm-swoop)

(helm-mode 1)
; doesn't seem to work
;(helm-adaptative-mode 1)
(helm-autoresize-mode 1)
(helm-push-mark-mode 1)


;; projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
; disable remote file caching
(setq projectile-file-exists-remote-cache-expire nil)


(helm-projectile-on)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "C-x b")   #'helm-mini)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)
(global-set-key (kbd "C-x C-m") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-r") #'helm-recentf)
(global-set-key (kbd "C-x r l") #'helm-filtered-bookmarks)
(global-set-key (kbd "M-y")     #'helm-show-kill-ring)

;;; SWOOP ;;; better i-search

(global-set-key (kbd "M-s") 'helm-swoop)
;; swoop-all searches all the buffers
(global-set-key (kbd "C-M-s") 'helm-multi-swoop-all)
;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-s") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-s") 'helm-multi-swoop-all-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; If this value is t, split window inside the current window
;;(setq helm-swoop-split-with-multiple-windows t)
;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-horizontally)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match t)

;; Disable pre-input
(setq helm-swoop-pre-input-function
      (lambda () ""))


;; If you prefer fuzzy matching
;;(setq helm-swoop-use-fuzzy-match t)

;;; HELM configs ;;;

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(setq helm-ff-transformer-show-only-basename nil
      helm-adaptive-history-file             "~/.emacs.d/data/helm-history"
      helm-yank-symbol-first                 t
      helm-move-to-line-cycle-in-source      t
      helm-buffers-fuzzy-matching            t
      helm-ff-auto-update-initial-value      t)

(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;; prevent from trying to open what's under the cursor for opening files
(setq helm-find-file-ignore-thing-at-point t)

;;; MISC ;;;
(setq find-grep-options "-q -i")
(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1)

;; auto-complete stuff
(require 'auto-complete-config)
(ac-config-default)

;;; auto-complete helm window - uses M--, next to dabbrev M-/
;; Note (mtourne): Not using often, maybe should replace dabbrev
(require 'ac-helm)  ;; Not necessary if using ELPA package
(global-set-key (kbd "M--") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "M--") 'ac-complete-with-helm)

;; paragraph movement
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

;;; will overwrite whatever is selected
(pending-delete-mode t)
;;; will surround a region with (), [], "" automatically
;;(electric-pair-mode t)
;;; test autopair instead
(require 'autopair)
(autopair-global-mode)  ;; enable autopair in all buffers

;;; Jumping Around ;;;
;; iy-go-to-char (go to char)
(require 'iy-go-to-char) ; installed by 'install-package' (melpa)
(global-set-key (kbd "M-m") 'iy-go-to-char)
(global-set-key (kbd "C-M-m") 'iy-go-to-char-backward)
;; ACE ;; jump around with a head char
(require 'ace-jump-mode)
(global-set-key (kbd "M-.") 'ace-jump-mode)
;; jump only in the current window (active buffer)
;; default ('global) is all windows & frames.
(setq ace-jump-mode-scope 'window)

;; goto last change
(require 'goto-chg)
(global-set-key (kbd "C-.") 'goto-last-change)
(global-set-key (kbd "C-,") 'goto-last-change-reverse)

;;; Opening New lines ;;;
;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "C-o") 'open-next-line)

 ;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one.
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "M-o") 'open-previous-line)

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")



;; open same buffer in other-window
(global-set-key [f5] (lambda () (interactive) (switch-to-buffer-other-window (buffer-name))))
;; finds dired
(global-set-key [f4] 'find-grep-dired)
(global-set-key [f3] 'find-name-dired)
(global-set-key [f2] 'find-dired)

;; compilation
(global-set-key [f8] 'recompile)

; this changes the default behavior of "some files have changes blablabla"
(add-to-list 'save-some-buffers-action-alist
             `(?k ,(lambda (buf) (kill-buffer buf))
                  ,(purecopy "do not save changes and kill the buffer")))

;;; fix mac os key layout
(setq set-keyboard-coding-system nil)
;;; option ;;;
(setq mac-option-key-is-meta nil)
(setq mac-option-modifier nil)
;(setq mac-option-key-is-meta t)
;(setq mac-option-modifier 'meta)
;;; command ;;;
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)

;; mac homebrew path
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

;;; inconsolata font
(set-default-font
 "-*-Source Code Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
;; set same font to new window
(add-to-list 'default-frame-alist
             '(font .  "-*-Source Code Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1"))


;;; Indentation ;;;
(setq-default indent-tabs-mode nil)
; xx (mtourne): not sure what this was for, screws up erlang mode.
;(setq-default tab-width 4)
(setq-default conf-basic-offset 4)
(setq c-basic-offset 4)
(setq js-indent-level 2)
(setq indent-line-function 'insert-tab)

(defun my-indent-setup ()
  (c-set-offset 'arglist-intro '+))
(add-hook 'c-mode-hook 'my-indent-setup)
(add-hook 'c++-mode-hook 'my-indent-setup)


;;; delete whitespace before saving ;;;
(add-hook 'before-save-hook 'delete-trailing-whitespace)
; to remove:
;  (remove-hook 'before-save-hook 'delete-trailing-whitespace)
; even last newline
;  (remove-hook 'before-save-hook 'nuke-trailing-whitespace)
;; delete all trailing, even last line
(defun nuke-trailing-whitespace ()
  "Deletes all blank lines at the end of the file, even the last one"
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines)
      (let ((trailnewlines (abs (skip-chars-backward "\n\t"))))
        (if (> trailnewlines 0)
            (progn
              (delete-char trailnewlines)))))))



;; vc-diff colors
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))))
 '(diff-removed ((t (:foreground "Red")))))


;;; Tags ;;;
;; all this is kinda borken
(setq tags-table-list (list "./" "./../" "./../../" "./../../../" "~/tags"))

;(require 'etags-table)
;(add-to-list 'etags-table-alist
;      (list
;       ;; For jumping to basics tags
;       '(".*\\.\\([ch]\\|cpp\\)" "~/tags/TAGS")
;       ;; For jumping across project:
;       '("~/Dev/nginx-modules/" "~/Dev/nginx/TAGS")
;       ))
;(setq etags-table-search-up-depth 10)
;(require 'etags-select)
;(global-set-key "\M-." 'etags-select-find-tag)


;; Lua
(require 'lua-mode)
(setq lua-default-application "/usr/local/bin/luajit")
(define-key lua-mode-map (kbd "C-c C-r") 'lua-send-region)


;; Disabled
(put 'erase-buffer 'disabled nil)

;; Salt
(add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode))


;;; NAVIGATION ;;;
;;; window movements
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window
;;; frame movement
(define-key global-map "\M-`" 'other-frame)
;;; like c-x o - too hard to reach
;; (global-set-key (kbd "C-<escape>") 'other-window)
;;; Note (mtourne): not sure what this is for?
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;; ace-window - smarter movement
(require 'ace-window)
(ace-window-display-mode)
(global-set-key (kbd "M-c") 'ace-window)
(setq aw-dispatch-always t)
;; makes the window switch key on the home row
(setq aw-keys '(?a ?o ?e ?u ?i ?1 ?2 ?3 ?4 ?5))
;; prevent other frames (windows) to be counted
;(setq aw-scope 'frame)
;; Note (mtourne): these don't seem to work
(defvar aw-dispatch-alist
  '((?x aw-delete-window " Ace - Delete Window")
    (?s aw-swap-window " Ace - Swap Window")
    (?p aw-flip-window " Ace - Previous window")
    (?v aw-split-window-vert " Ace - Split Vert Window")
    (?h aw-split-window-horz " Ace - Split Horz Window")
    (?m delete-other-windows " Ace - Maximize curr Window")
    )
  "List of actions for `aw-dispatch-default'.")

;;; GIT - magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; DISABLED
;; compose-mail C-x m - hitting instead of C-x b
(global-unset-key (kbd "C-x m"))
