" Python
if executable("python")
  " autocmd BufRead,BufNewFile *.py map <F5> :% w !python<CR>
  "autocmd BufRead,BufNewFile *.py map <F5> :w<cr>:!python %<CR>
  autocmd BufRead,BufNewFile *.py map <F5> :execute 'ConqueTermSplit ipython '.expand('%:p')<CR>
  "autocmd BufRead,BufNewFile *.py map <F5> :call conque_term#open('ipython', ['split', 'resize 20'], 1)<CR>
else
  autocmd BufRead,BufNewFile *.py map <F5> :echo "you need to install Python first!"<CR>
endif
