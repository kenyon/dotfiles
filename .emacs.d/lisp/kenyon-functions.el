;; Functions and other definitions loaded by my init.el.

(when (string= (system-name) "gauss.kenyonralph.com")
  (display-battery-mode t))

(when (string= (system-name) "copernicus.kenyonralph.com")
  (display-battery-mode t))

(defun my-c-initialization-hook ()
  (define-key c-mode-base-map (kbd "C-j") 'c-context-line-break))

;; From http://www.emacswiki.org/emacs/RecenterLikeVi
(defun ctrl-e-in-vi (n)
  (interactive "p")
  (scroll-up n))

(defun ctrl-y-in-vi (n)
  (interactive "p")
  (scroll-down n))

;; From http://www.emacswiki.org/emacs/OpenNextLine
; Autoindent open-*-lines.
(defvar newline-and-indent nil
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

; Behave like vi's o command.
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

; Behave like vi's O command.
(defun open-previous-line (arg)
  "Open a new line before the current one.
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))
