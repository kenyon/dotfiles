(setq-default buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(modify-coding-system-alist 'process "plink" 'utf-8-unix)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(load "kenyon-functions")

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Appearance settings.
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Mode settings.
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'same-window-buffer-names "*Buffer List*")
(add-hook 'c-initialization-hook 'my-c-initialization-hook)
(add-hook 'org-mode-hook 'turn-off-flyspell)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'dired-load-hook (lambda () (load "dired-x")))
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
; These w3m settings need to be in this order, so they can't be set by
; customize.
(setq-default w3m-key-binding (quote info))
(setq-default w3m-init-file "~/.emacs.d/lisp/emacs-w3m.el")
(add-to-list 'auto-mode-alist '("/tmp/mutt-" . mail-mode))
(add-hook 'mail-mode-hook 'turn-on-auto-fill)

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdwn" . markdown-mode))

; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)

;; Key bindings.
(global-set-key (kbd "M-n") 'ctrl-e-in-vi)
(global-set-key (kbd "M-p") 'ctrl-y-in-vi)
(global-set-key (kbd "M-o") 'open-previous-line)
(global-set-key (kbd "C-o") 'open-next-line)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(windmove-default-keybindings)

;; dwim C-a: move to indentation or beginning of line if already there
(defun beginning-of-indentation-or-line ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))
(global-set-key (kbd "C-a") 'beginning-of-indentation-or-line)

(require 'syntax-subword)

(global-set-key (kbd "M-/") 'hippie-expand)

;; External libraries and their settings.

; http://www.emacswiki.org/emacs/ColumnMarker
(require 'column-marker)

; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)

; http://www.emacswiki.org/emacs/uniquify
(require 'uniquify)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-name-width 40)
 '(TeX-PDF-mode t)
 '(TeX-save-query nil)
 '(apropos-do-all t)
 '(auto-image-file-mode t)
 '(auto-revert-remote-files t)
 '(blink-cursor-mode nil)
 '(browse-url-browser-function 'w3m-browse-url)
 '(c-default-style '((java-mode . "java") (awk-mode . "awk") (other . "bsd")))
 '(calendar-date-style 'iso)
 '(calendar-latitude 32.9)
 '(calendar-longitude -117.2)
 '(calendar-time-display-form
   '(24-hours ":" minutes
              (if time-zone " (")
              time-zone
              (if time-zone ")")))
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(compilation-ask-about-save nil)
 '(cperl-indent-level 8)
 '(default-major-mode 'text-mode t)
 '(dictionary-server "localhost")
 '(diff-switches "-u")
 '(directory-free-space-args "-h")
 '(dired-listing-switches "-alhF")
 '(dired-ls-F-marks-symlinks t)
 '(display-time-world-list
   '(("America/Los_Angeles" "San Diego")
     ("America/New_York" "New York")
     ("Europe/London" "London")
     ("Europe/Paris" "Paris")
     ("Asia/Kolkata" "Bangalore")
     ("Asia/Tokyo" "Tokyo")))
 '(dynamic-completion-mode t)
 '(elpamr-default-output-directory "~/git/myelpa")
 '(erin-mode-hook '(visual-line-mode))
 '(exec-path
   '("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_14" "/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_14" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin"))
 '(find-ls-option '("-exec ls -ldFh {} \\;" . "-ldFh"))
 '(global-auto-revert-mode t)
 '(global-company-mode t)
 '(global-cwarn-mode t)
 '(global-flycheck-mode t)
 '(global-hl-line-mode t)
 '(global-syntax-subword-mode t)
 '(haskell-mode-hook '(turn-on-haskell-indent))
 '(horizontal-scroll-bar-mode nil)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-mode 'both nil (ido))
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(ispell-program-name "aspell")
 '(kill-do-not-save-duplicates t)
 '(kill-ring-max 200)
 '(list-directory-verbose-switches "-Flh")
 '(menu-bar-mode nil)
 '(message-kill-buffer-on-exit t)
 '(minimap-width-fraction 0.15)
 '(mode-require-final-newline 'visit-save)
 '(mouse-avoidance-mode 'animate nil (avoid))
 '(notmuch-fcc-dirs '(("sent")))
 '(notmuch-message-headers
   '("Subject" "To" "Cc" "Date" "User-Agent" "X-Mailer" "Delivered-To" "X-Spam-Checker-Version" "X-Spam-Status" "List-Id"))
 '(notmuch-show-all-tags-list t)
 '(org-archive-save-context-info '(time file category todo priority itags olpath ltags))
 '(org-default-notes-file "~/git/sysadmin/todo/.notes")
 '(org-directory "~/git/sysadmin/todo")
 '(org-disputed-keys
   '(([(shift up)]
      .
      [(nil)])
     ([(shift down)]
      .
      [(nil)])
     ([(shift left)]
      .
      [(meta -)])
     ([(shift right)]
      .
      [(meta +)])
     ([(control shift right)]
      .
      [(meta shift +)])
     ([(control shift left)]
      .
      [(meta shift -)])))
 '(org-enforce-todo-dependencies t)
 '(org-export-with-priority t)
 '(org-insert-mode-line-in-empty-file t)
 '(org-log-done 'time)
 '(org-log-redeadline 'time)
 '(org-log-reschedule 'time)
 '(org-replace-disputed-keys t)
 '(org-special-ctrl-a/e t)
 '(org-startup-folded nil)
 '(package-selected-packages
   '(gitconfig-mode gitattributes-mode gitignore-mode git-commit async jenkinsfile-mode groovy-mode elpa-mirror poly-ansible systemd lua-mode syntax-subword powershell yaml-mode tabbar session initsplit htmlize haskell-mode graphviz-dot-mode folding eproject diminish debian-el csv-mode browse-kill-ring boxquote bm bar-cursor apache-mode smex puppet-mode markdown-mode flycheck company))
 '(require-final-newline 'visit-save)
 '(save-place-mode t nil (saveplace))
 '(savehist-mode t nil (savehist))
 '(scroll-bar-mode nil)
 '(scroll-preserve-screen-position t)
 '(sentence-end-double-space nil)
 '(server-kill-new-buffers nil)
 '(server-temp-file-regexp
   "^/tmp/Re\\|/draft$\\|COMMIT_EDITMSG\\|^/tmp/mutt-\\|^/tmp/vimperator-\\|^/tmp/cvs\\|^/tmp/crontab\\|^/tmp/zshecl")
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tramp-default-proxies-alist
   '(((regexp-quote
       (system-name))
      nil nil)
     (nil "\\`root\\'" "/ssh:%h:")))
 '(uniquify-buffer-name-style 'forward nil (uniquify))
 '(vc-cvs-diff-switches "-u")
 '(visible-bell t)
 '(visible-cursor nil)
 '(w3m-arrived-file "~/.w3m/.arrived")
 '(w3m-bookmark-file "~/.w3m/bookmarks.html")
 '(w3m-bookmark-file-coding-system 'utf-8)
 '(w3m-coding-system 'utf-8)
 '(w3m-confirm-leaving-secure-page nil)
 '(w3m-default-coding-system 'utf-8)
 '(w3m-file-coding-system 'utf-8)
 '(w3m-file-name-coding-system 'utf-8)
 '(w3m-form-input-textarea-buffer-lines 20)
 '(w3m-form-textarea-directory "~/.w3m/.textarea")
 '(w3m-session-file "~/.w3m/.sessions")
 '(w3m-terminal-coding-system 'utf-8)
 '(w3m-use-cookies t)
 '(winner-mode t nil (winner))
 '(zoneinfo-style-world-list
   '(("America/Los_Angeles" "San Diego")
     ("America/New_York" "New York")
     ("Europe/London" "London")
     ("Europe/Paris" "Paris")
     ("Asia/Kolkata" "Bangalore")
     ("Asia/Tokyo" "Tokyo"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 80))))
 '(glyphless-char ((t nil))))

(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)

; http://www.emacswiki.org/emacs/Smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "<menu>") 'smex)
(global-set-key (kbd "<apps>") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; Non-smex M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(smex-auto-update)

(server-start)
