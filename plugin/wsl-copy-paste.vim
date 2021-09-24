if &compatible || exists('g:loaded_wsl_copy_paste')
    finish
endif

if !(has('unix') && exists('$WSLENV'))
  finish
endif

if executable('clip.exe')
  function! SendToClip(type, ...) abort
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

  nnoremap <silent> cy      :set operatorfunc=SendToClip<cr>g@
  xnoremap <silent> Y       :<C-U>call SendToClip(visualmode(),1)<cr>
endif

if executable('pwsh.exe')
  let s:pwsh = 'pwsh.exe'
elseif executable('powershell')
  let s:pwsh = 'powershell.exe'
endif

if exists('s:pwsh')
  let s:cmd = s:pwsh . ' -NoProfile -command Get-Clipboard'

  function! ClipToReg() abort
    " From https://superuser.com/questions/1291425/windows-subsystem-linux-make-vim-use-the-clipboard/1666502#1666502
    silent let clipboard = system(s:cmd)
    let clipboard = substitute(clipboard, '\r\n', '\n', 'g')
    let clipboard = substitute(clipboard, '\n$', '', '')
    " clipboard register + fails!
    call setreg('+', clipboard)
  endfunction

  nnoremap <silent> cp :<c-u>call ClipToReg()<cr>"+p
  nnoremap <silent> cP :<c-u>call ClipToReg()<cr>"+P
  xnoremap <silent>  P :<c-u>call ClipToReg()<cr>gv"+p
endif

let g:loaded_wsl_copy_paste = 1
