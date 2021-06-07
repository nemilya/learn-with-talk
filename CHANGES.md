2021-06-07
----------

- `db/migrate.db` for init sqlite DB
- model User, with CRUD, and `login_as`
- model Content, with CRUD
- model Word with create/delete
- class wrapper for `youtube-dl`
- download subtitles (`ttml` format, `en`) to folder `subtitles`
- parsing `ttml` xml format (extract `begin`, `end`, `text`)
- content page (video page) with subtitles - one subtitle per lines (~3 sec per line, as in `ttml`)
- for subtitle line - is possible to add word (original/translation)
- added youtube player on video page, with seekTo to position on video from specific subtitle line

plans:

- add VueJs to video page
