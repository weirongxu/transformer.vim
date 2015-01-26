#!/usr/bin/env bash
vim -c 'noremap Q :qa<cr> | map R :q<cr>:q<cr>:Vader run.vader<cr> | Vader run.vader'
