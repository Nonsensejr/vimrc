" Apperance
colorscheme molokai 
set nu
set cc=80
set cursorline
set nu
hi CursorLine term=bold cterm=bold guibg=Grey40

" Project specific vimrc
set exrc


" Set NerdTree to left
let g:NERDTreeWinPos = "left"


" Remember where you left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Map Splits
nnoremap <leader>\| :vsplit<cr> 
nnoremap <leader>- :split<cr> 


" Map Toggle NERDTree
map <F9> :NERDTreeToggle<cr>
map <F10> :TagbarToggle<cr>

" Reset Syntastic Window
map <C-c> :SyntasticReset<cr>

" Lightline theme
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'component': {
  \   'readonly': '%{&readonly?"":""}',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }



" Close NERDTree when all buffer closed 
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
