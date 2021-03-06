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
                  markdown-mode  goto-chg
                  git-modes f s pkg-info epl el-get
                  magit dash color-theme auto-complete popup cl-lib fuzzy
                  projectile    ;; project based stuff - ever used ?
                  helm helm-swoop   ;; window for picking
                  lua-mode

                  ace-window    ;; jump between windows
                  avy           ;; jump to characters - replaces ace-jump-mode
                  ac-helm helm-projectile
                  rjsx-mode js2-mode    ;; javascript
		  autopair      ;; closing parens / quotes
                  expand-region ;; C-= expand selection
                  restclient    ;; easily describe/test rest endpoints

                  neotree       ;; add a bar to go through directories,
                                ;; useful for directory-organized protjects

		  material-theme

                  powerline
                  spaceline
                  ;; deprecs :
                  ;; ample-regexps ;; design regex; never used see helm-regexp

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
(global-set-key (kbd "C-x =") 'er/expand-region)


;;; Emacs Faces ;;;;
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Remove splash screen
(setq inhibit-splash-screen t)


;;; powerline ;;;
;;(require 'powerline)
;;(powerline-default-theme)

;;; spaceline ;;;
;; (require 'spaceline-config)
;; (spaceline-spacemacs-theme)

;;; Color Theme ;;;

;;; good one
(load-theme 'ample-zen t)
;;; good light
;;(load-theme 'ample-light t)

;; color-theme doesn't need to be required anymore
;;(require 'color-theme)
;;(color-theme-initialize)

;; old customized color-theme-tango
;; in `dotstuff/emacs/color-theme-tango.el`
;;(require 'color-theme-tango)
;;(color-theme-tango)

;; invert face (colore theme is better)
;(invert-face 'default)

;;;; Config (generated) ;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" default)))
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(fci-rule-color "#37474f")
 '(hl-sexp-background-color "#1c1f26")
 '(js2-basic-offset 2)
 '(mouse-wheel-mode t)
 '(package-selected-packages
   (quote
    (protobuf-mode ample-theme ample-zen-theme gruvbox-theme clipmon rjsx-mode)))
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


;;; PROJECTILE ;;; - may deprec
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
;; (global-set-key (kbd "C-x C-m") #'helm-M-x)
;; replace M-x with helm-M-x
(global-set-key (kbd "M-x") #'helm-M-x)

;; helm find files
; You can invoke grep on the currently highlighted entry with C-s. C-u C-s performs a recursive grep.
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(global-set-key (kbd "C-x C-r") #'helm-recentf)
(global-set-key (kbd "C-x r l") #'helm-filtered-bookmarks)


;; kill-ring doesn't add system clipboard stuff, enter clipmon which is supposed to do that
;; monitor the system clipboard and add any changes to the kill ring
(require 'clipmon)
(add-to-list 'after-init-hook 'clipmon-mode-start)
(setq clipmon-timer-interval 1) ;; insert every second
;; XX (mtourne): added C-y as well since I seem to always C-y, undo and then M-y
;; Removed: as it always becomes a two step paste - kept clipmon
;;(global-set-key (kbd "C-y")     #'helm-show-kill-ring)
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
;; from : https://tuhdo.github.io/helm-intro.html

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

;; (setq helm-autoresize-max-height 0)
;; (setq helm-autoresize-min-height 20)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;; prevent from trying to open what's under the cursor for opening files
(setq helm-find-file-ignore-thing-at-point t)

(helm-autoresize-mode 1)
(helm-mode 1)


;;; MISC ;;;
(setq find-grep-options "-q -i")
(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1)

;;;; COMPLETION ;;;;

;;; auto-complete - deprecated
;;(require 'auto-complete-config)
;;(ac-config-default)

;;; COMPANY 'auto-complete 'anything' - replaces auto-complete
(add-hook 'after-init-hook 'global-company-mode)
;; ;; pick with a number in the completion list
;; ;; Note (mtourne): default picking a number collides with TotalSpaces in MacOS
;; ;; remapping to C-<1 through 10>
;; (setq company-show-numbers t)
;; (defun setup_company_macro ()
;;   (dotimes (i 10)
;;     (define-key company-active-map (read-kbd-macro (format "C-%d" i))
;;       'company-complete-number))
;;   )
;; ;; run macro setting after this (add-hook 'after-init-hook 'global-company-mode)
;; ;; ie: in a after-init-hook as well.
;; (add-hook 'after-init-hook 'setup_company_macro)


;;; HELM Window - uses M--, next to dabbrev M-/

;;; auto-complete window
;;(require 'ac-helm)  ;; Not necessary if using ELPA package
;;(global-set-key (kbd "M--") 'ac-complete-with-helm)
;;(define-key ac-complete-mode-map (kbd "M--") 'ac-complete-with-helm)
;; use helm-dabbrev to complete anything - instead of ac-helm (helm autocomplete)

;;; dabbrev window
(require 'helm-dabbrev)
(setq helm-dabbrev-always-search-all t)
(global-set-key (kbd "M--") 'helm-dabbrev)

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
(add-hook 'python-mode-hook
          #'(lambda ()
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))

;;; Jumping Around ;;;
;;; iy-go-to-char (go to char)
;;; deprecated - replaced M-m with avy.
;;(require 'iy-go-to-char) ; installed by 'install-package' (melpa)
;;(global-set-key (kbd "M-m") 'iy-go-to-char)
;;(global-set-key (kbd "C-M-m") 'iy-go-to-char-backward)
;;; ACE ;; jump around with a head char - deprecated in favor of avy
;; (require 'ace-jump-mode)
;; ;;; jumps to the beginning of a word
;; ;; (global-set-key (kbd "M-.") 'ace-jump-mode)
;; ;;; jumps to the any char
;; (global-set-key (kbd "M-.") 'ace-jump-char-mode)
;; ;; jump only in the current window (active buffer)
;; ;; default ('global) is all windows & frames.
;; ;; (setq ace-jump-mode-scope 'window)
;; (setq ace-jump-mode-scope 'global)

;;; AVY - jump to things
;; Note (mtourne): quite like this adding M-m
;; keeping M-. as well

;; pick two chars and then jump
;; (global-set-key (kbd "M-.") 'avy-goto-char-2)

;; timer 0.5 s to type as many chars as wanted
(global-set-key (kbd "M-.") 'avy-goto-char-timer)
;; replaced iy-go-to-char with avy
(global-set-key (kbd "M-m") 'avy-goto-char-timer)

;; C-u <avy shortcut> will do only only buffer highligted (opposite all-windows)
;; make that behavior a stand alone function
;; to search only the current buffer
(defun avy-goto-char-timer-this-window ()
  (interactive)
  (let ((avy-all-windows nil))
    (avy-goto-char-timer)))
(global-set-key (kbd "M-,") 'avy-goto-char-timer-this-window)

;; goto highligted line ;; may change to M-l if useful
(global-set-key (kbd "M-g l") 'avy-goto-line)

(setq avy-all-windows 'all-frames)
;;(setq avy-all-windows nil)
;; mildly useful: jump faster to an isearch visible result using avy
;; mapped C-. and M-. in that mode to accomody for mistypes
;; (eval-after-load "isearch"
;;   '(define-key isearch-mode-map (kbd "M-m") 'avy-isearch)
;;   )
(eval-after-load "isearch"
  '(define-key isearch-mode-map (kbd "C-.") 'avy-isearch)
  )
(eval-after-load "isearch"
  '(define-key isearch-mode-map (kbd "M-.") 'avy-isearch)
  )

;; goto last change
(require 'goto-chg)
(global-set-key (kbd "C-.") 'goto-last-change)
(global-set-key (kbd "C-,") 'goto-last-change-reverse)

;; for console emacs where C-. / C-, is not working
(global-set-key (kbd "C-x .") 'goto-last-change)
(global-set-key (kbd "C-x ,") 'goto-last-change-reverse)


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


;;; DELETING ;;;;

;; whitespace

;; delete up to non-whitespace
;; Note (mtourne): this is non ideal.
;;  I need to write a function so that control backspace does :
;;  delete last word unless there is a line break and then only does fixup-whitespace
;; (global-set-key [(shift backspace)] 'fixup-whitespace)

;; potential answer from
;; https://emacs.stackexchange.com/questions/30401/backward-kill-word-kills-too-much-how-to-make-it-more-intelligent

;; (defun backward-kill-char-or-word ()
;;   "Delete the character or word before point."
;;   (interactive)
;;   (if (looking-back "\\w" 1)
;;       (backward-kill-word 1)
;;     (backward-delete-char 1)))
;;
;; (defun backward-kill-char-or-word ()
;;   (interactive)
;;   (cond
;;    ((looking-back (rx (char word)) 1)
;;     (backward-kill-word 1))
;;    ((looking-back (rx (char blank)) 1)
;;     (delete-horizontal-space t))
;;    (t
;;     (backward-delete-char 1))))


;; adapted from
;; https://stackoverflow.com/questions/13896402/kill-word-forward-word-should-stop-at-newline
;; this is not perfect as it will not go past the beginning of the line.

(defun backward-word-stop-eol (arg)
  (interactive "p")
  (let ((start (point)))
    (save-restriction
      (save-excursion
        (move-beginning-of-line 1)
        (narrow-to-region start (point)))
      (backward-word arg))))

(defun backward-kill-word-stop-eol (arg)
  (interactive "p")
  (kill-region (point) (progn (backward-word-stop-eol arg) (point))))

(global-set-key [(shift backspace)] 'backward-kill-word-stop-eol)

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

;;; Neotre -- explore tree structure
;;(require 'neotree)
(global-set-key [f10] 'neotree-toggle)

;;; GIT - magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)


;;; RESTclient
;; make .rst // .rest files to describe REST commands
(setq auto-mode-alist
      (append '(("\\.rst$" . restclient-mode)
                ("\\.rest$" . restclient-mode)) auto-mode-alist))

;; DISABLED
;; compose-mail C-x m - hitting instead of C-x b
(global-unset-key (kbd "C-x m"))


;; Remote edit
(defun connect-pisa ()
  (interactive)
  (dired "/mtourne@75.101.62.121:/"))
