let s:source = {
        \   'name' : 'oldfiles',
        \   'description' : 'candidates from v:oldfiles',
        \   'default_kind' : 'file',
        \   'hooks' : {},
        \ }

function! unite#sources#oldfiles#define() abort
    return s:source
endfunction

function! s:source.gather_candidates(args, context) abort
    return map(filter(copy(v:oldfiles), 'filereadable(expand(v:val))'), '{
            \   "word": v:val,
            \   "action__path": expand(v:val),
            \}')
endfunction

function! s:source.hooks.on_init(args, context) abort
    " Reload ~/.viminfo for files opened after this Vim had started
    wviminfo
    rviminfo!
endfunction
