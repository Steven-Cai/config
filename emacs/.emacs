;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename:      .emacs
;;               
;; Copyright (C) 2013,  Steven Cai
;; Version:       20130717
;; Author:        Steven <stevencaiyaohua#gmail.com>
;; Created at:    Wed July 17 15:56:07 2013
;;               
;; Description:   
;;                
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
;;**********************    basic setting    *********************

;;设置用户信息
(setq user-full-name "Steven Cai")
(setq user-mail-address "stevencaiyaohua@gmail.com")

;;启用时间显示设置，在minibuffer上面的那个杠上（忘了叫什么来着）
(display-time-mode 1)
 
;;时间使用24小时制
(setq display-time-24hr-format t)
 
;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
 
;;时间栏旁边启用邮件设置
(setq display-time-use-mail-icon t)
 
;;时间的变化频率
(setq display-time-interval 10)
 
;;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;; 设置默认tab宽度为4
(setq tab-width 4
indent-tabs-mode t
c-basic-offset 4)

;; 回车缩进
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)

;;支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; 语法高亮
(global-font-lock-mode t)

;;显示行号
;;(global-linum-mode t)

;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)

;; 把 fill-column 设为 60. 这样的文字更好读
(setq default-fill-column 60)

;; 显示括号匹配 
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 在标题栏显示buffer的名字
(setq frame-title-format "emacs@%b")

;; 关闭工具栏
(tool-bar-mode nil)

;;去掉菜单栏
(menu-bar-mode nil)

;滚动页面时比较舒服，不要整页的滚动
(setq     scroll-step 1
	  scroll-margin 3
	  scroll-conservatively 10000) 

;;emacs 默认的滚动条是在左侧, 现在放到右侧
(customize-set-variable 'scroll-bar-mode 'right)

;; 以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;关闭自动保存模式
(setq auto-save-mode nil)

;;不要生成临时文件
(setq-default make-backup-files nil)

;;配置auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-engine 'xetex)
(setq TeX-PDF-mode t)

;;配置Markdown-mode
(add-to-list 'load-path "~/.emacs.d/modes")
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))

;;Coding style for Linux kernel
(defun linux-c-mode ()
   "C mode with adjusted defaults for use with the Linux kernel."
(interactive)
(c-mode)
(c-set-style "K&R")
(setq tab-width 8)
(setq indent-tabs-mode t)
(setq c-basic-offset 8))
(add-to-list 'auto-mode-alist '("\.c$" . linux-c-mode))

;;配置Cscope
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(require 'xcscope)
;; 设置仅在打开c/c++文件时才加载xcscope
(add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
;; 打开cscope时不更新，提高索引速度
(setq cscope-do-not-update-database t)