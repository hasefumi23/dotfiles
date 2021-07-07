# Vim cheatsheet

## Commands

### Quickfix

- 記事
    - https://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b

```vim
" 書式
vim[grep] {pattern} {file} ...
" カレントバッファを対象にする
:vim {pattern} %
" インデックスされている全てのファイルを対象にする
:vim {pattern} `git ls-files`
" バッファされている全てのファイルに対して検索する
:bufdo vimgrepa {pattern} %
" Quickfixをリセットする
:cex ""
" quickfix-windows
:vim {pattern} {file} | cw
```
