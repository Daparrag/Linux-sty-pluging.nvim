

if exists('g:loaded_linuxsty') | finish | endif " Prevent loading twice 
let g:loaded_linuxsty = 1 
set wildignore+=*.ko,*.mod.c,*.order,modules.builtin


" command to run the style 
lua my_style = require('linux-sty-plugin')
" said hello to users 
" lua my_style.run()

augroup linuxsty
    autocmd!
    autocmd FileType c,cpp,cc,h,hpp lua my_style.linux_style_apply()
    autocmd FileType diff setlocal ts=8 
    autocmd FileType rst setlocal ts=8 sw=8 sts=8 noet
    autocmd FileType kconfig setlocal ts=8 sw=8 sts=8 noet
    autocmd FileType dts setlocal ts=8 sw=8 sts=8 noet
augroup END

" lets create individual commands 
command! LinuxCodingStyle lua my_style.linux_style_apply()




