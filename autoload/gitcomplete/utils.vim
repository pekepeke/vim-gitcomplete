let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#utils#to_comp(list)
  return map(a:list, "{ 'word': v:val, 'menu': 'git' }")
endfunction


function! gitcomplete#utils#has_arg(cmdline, args)
  return index(a:cmdline[: -2], a:args) >= 0
endfunction


function! gitcomplete#utils#get_gitdir()
  if isdirectory('.git')
    return '.git'
  endif
  let s = vimproc#system('git rev-parse --git-dir')
  return vimproc#get_last_status() == 0 ? split(s, '\n')[0] : ''
endfunction


function! gitcomplete#utils#heads()
  let s = vimproc#system(
  \         "git for-each-ref --format='%(refname:short)' refs/heads")
  return vimproc#get_last_status() == 0 ?
  \        gitcomplete#utils#to_comp(split(s, '\n')) : []
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
