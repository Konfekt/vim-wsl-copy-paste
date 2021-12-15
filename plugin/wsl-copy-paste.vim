if &compatible || exists('g:loaded_wsl_copy_paste')
  finish
endif

if !(has('unix') && exists('$WSLENV'))
  finish
endif

" To send to clipboard {{{
if executable('clip.exe')
  function! SetClip(type, ...) abort
    if a:0
      " Visual mode
      normal! gv"+y
    elseif a:type ==# 'line'
      normal! '[V']"+y
    elseif a:type ==# 'char'
      normal! `[v`]"+y
    endif

    " From https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows/50281147#50281147
    call system('clip.exe', @+)
  endfunction

  nnoremap <silent> cy      :set operatorfunc=SetClip<cr>g@
  xnoremap <silent> Y       :<C-U>call SetClip(visualmode(),1)<cr>
endif
" }}}

" To receive from clipboard {{{
if executable('pwsh.exe')
  let s:pwsh = 'pwsh.exe'
elseif executable('powershell.exe')
  let s:pwsh = 'powershell.exe'
endif

if exists('s:pwsh')
  let s:cmd = s:pwsh . ' -NoProfile -command Get-Clipboard'

  function! GetClip() abort
    " From https://superuser.com/questions/1291425/windows-subsystem-linux-make-vim-use-the-clipboard/1666502#1666502
    silent let clipboard = system(s:cmd)
    let clipboard = substitute(clipboard, '\r\n', '\n', 'g')
    let clipboard = substitute(clipboard, '\n$', '', '')
    " clipboard register + fails!
    call setreg('9', clipboard)
  endfunction

  nnoremap <silent><expr> cp ':<c-u>call GetClip()<cr>' . v:count . '"9p:<c-u>silent! call repeat#set("cp",' . v:count . ')<cr>'
  nnoremap <silent><expr> cP ':<c-u>call GetClip()<cr>' . v:count . '"9P:<c-u>silent! call repeat#set("cP",' . v:count . ')<cr>'

  xnoremap <silent>        P  :<c-u>call GetClip()<cr>gv"9p
endif
" }}}

let g:loaded_wsl_copy_paste = 1
