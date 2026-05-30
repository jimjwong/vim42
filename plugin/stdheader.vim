" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    stdheader.vim                                      :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: vim42 setup                                +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2026/05/30 00:00:00 by vim42             #+#    #+#              "
"    Updated: 2026/05/30 00:00:00 by vim42            ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" Attribution:
" This 42 header plugin is based on the original 42Paris/42header project.
" Original source: https://github.com/42Paris/42header
" Full credit for the 42 header plugin and header format goes to 42Paris/42header.
"

if exists('g:loaded_vim42_stdheader')
	finish
endif
let g:loaded_vim42_stdheader = 1

let s:asciiart = [
			\ '       :::      ::::::::',
			\ '     :+:      :+:    :+:',
			\ '   +:+ +:+         +:+  ',
			\ ' +#+  +:+       +#+     ',
			\ '+#+ +#+#+#+#+#+   +#+        ',
			\ '     #+#    #+#          ',
			\ '    ###   ########.fr    '
			\ ]

let s:length = 80
let s:margin = 5
let s:start = '/*'
let s:end = '*/'
let s:fill = '*'

let s:types = {
			\ '\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.tpp$\|\.ipp$\|\.cxx$\|\.go$\|\.rs$\|\.php$\|\.py$\|\.java$\|\.kt$\|\.kts$': ['/*', '*/', '*'],
			\ '\.htm$\|\.html$\|\.xml$': ['<!--', '-->', '*'],
			\ '\.js$\|\.ts$': ['//', '//', '*'],
			\ '\.tex$': ['%', '%', '*'],
			\ '\.ml$\|\.mli$\|\.mll$\|\.mly$': ['(*', '*)', '*'],
			\ '\.vim$\|vimrc$': ['"', '"', '*'],
			\ '\.el$\|\.emacs$\|\.asm$': [';', ';', '*'],
			\ '\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$': ['!', '!', '/'],
			\ '\.lua$': ['--', '--', '-'],
			\ '\.sh$\|\.bash$\|\.zsh$': ['#', '#', '*']
			\ }

function! s:filetype() abort
	let l:f = s:filename()
	let s:start = '#'
	let s:end = '#'
	let s:fill = '*'

	for l:type in keys(s:types)
		if l:f =~ l:type
			let s:start = s:types[l:type][0]
			let s:end = s:types[l:type][1]
			let s:fill = s:types[l:type][2]
		endif
	endfor
endfunction

function! s:user() abort
	if exists('g:user42')
		return g:user42
	endif

	let l:user = $USER
	if strlen(l:user) == 0
		let l:user = 'marvin'
	endif
	return l:user
endfunction

function! s:mail() abort
	if exists('g:mail42')
		return g:mail42
	endif

	let l:mail = $MAIL
	if strlen(l:mail) == 0
		let l:mail = 'marvin@42.fr'
	endif
	return l:mail
endfunction

function! s:filename() abort
	let l:filename = expand('%:t')
	if strlen(l:filename) == 0
		let l:filename = '< new >'
	endif
	return l:filename
endfunction

function! s:date() abort
	return strftime('%Y/%m/%d %H:%M:%S')
endfunction

function! s:ascii(n) abort
	return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right) abort
	let l:left = strpart(a:left, 0, s:length - s:margin * 2 - strlen(a:right))
	return s:start
				\ . repeat(' ', s:margin - strlen(s:start))
				\ . l:left
				\ . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right))
				\ . a:right
				\ . repeat(' ', s:margin - strlen(s:end))
				\ . s:end
endfunction

function! s:line(n) abort
	if a:n == 1 || a:n == 11
		return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
	elseif a:n == 2 || a:n == 10
		return s:textline('', '')
	elseif a:n == 3 || a:n == 5 || a:n == 7
		return s:textline('', s:ascii(a:n))
	elseif a:n == 4
		return s:textline(s:filename(), s:ascii(a:n))
	elseif a:n == 6
		return s:textline('By: ' . s:user() . ' <' . s:mail() . '>', s:ascii(a:n))
	elseif a:n == 8
		return s:textline('Created: ' . s:date() . ' by ' . s:user(), s:ascii(a:n))
	elseif a:n == 9
		return s:textline('Updated: ' . s:date() . ' by ' . s:user(), s:ascii(a:n))
	endif
	return ''
endfunction

function! s:insert() abort
	let l:line = 11
	call append(0, '')

	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update() abort
	call s:filetype()

	if getline(9) =~ 'Updated: '
		if &modified
			call setline(9, s:line(9))
		endif
		call setline(4, s:line(4))
		return 0
	endif

	return 1
endfunction

function! s:stdheader() abort
	call s:filetype()

	if s:update()
		call s:insert()
	endif
endfunction

command! Stdheader call s:stdheader()

nnoremap <silent> <F1> :Stdheader<CR>
autocmd BufWritePre * call s:update()
