#echo -debug "loaded kakrc" 

# plugins

source "%val{config}/plugins/plug.kak/rc/plug.kak"

## buffers

plug "Delapouite/kakoune-buffers" %{
    # Suggested hook
    hook global WinDisplay .* info-buffers

    # Suggested aliases

    map global buffers r ":edit ~/misc/kak-requests<ret>" -docstring "edit kak-requests"
    alias global bd delete-buffer
    alias global bf buffer-first
    alias global bl buffer-last
    alias global bo buffer-only
    alias global bo! buffer-only-force

    # ciao macros
    map global normal ^ q
    map global normal <a-^> Q

    map global normal q b
    map global normal Q B
    map global normal <a-q> <a-b>
    map global normal <a-Q> <a-B>

    map global normal b ':enter-buffers-mode<ret>'              -docstring 'buffers…'
    map global normal B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
}

# highlighters

plug "alexherbo2/toggle-highlighter.kak"
map global user w ": toggle-highlighter window/ show-whitespaces<ret>" -docstring "show whitespace"
set-face global Whitespace default+d
add-highlighter global/ number-lines
add-highlighter global/ show-matching
set-face global MatchingChar default+Bu #blink underling 
add-highlighter global/ column 80 red+f

## tabs

plug "andreyorst/smarttab.kak" %{
    set-option global softtabstop 4
    set-option global tabstop 4
    hook global WinSetOption ^[^*]+$ expandtab
}

# lsp

eval %sh{kak-lsp --kakoune -s $kak_session}
lsp-enable
map global normal <space> ":enter-user-mode lsp<ret>"
map global goto n "<esc>:lsp-find-error<ret>" -docstring "lsp next lint error"
map global goto p "<esc>:lsp-find-error --previous<ret>" -docstring "lsp previous lint error"


# python stuff
hook global WinSetOption filetype=python %{
    set-option global lintcmd kak_pylint
    map global user l "<esc>:lint<ret>" -docstring "lint"
    # lspy
    set-option global lsp_server_configuration pyls.plugins.pylint="true"
    lint-enable
    set-option global formatcmd 'black - --fast'
    map global user f "<esc>:format<ret>"
    hook global BufWritePre "" %{
        echo "f o r m a t"
        format
    }
}


