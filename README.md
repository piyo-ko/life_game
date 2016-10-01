# 絵文字でライフゲーム / Game of Life with emoji characters

絵文字でライフゲームをしたら楽しいかな、と思って書いてみたら、割と楽しかった。
スクリプト中の定数をお好みで書き換えて使ってください。

Enjoy Game of Life with emoji characters.
You may feel like rewriting the constants in `life_game.pl`.  Some other choices of emoji characters are also included in `life_game.pl`, but they are commented out.

## 使用例 / Use example
````sh
$ ./life_game.pl < pat4.dat

...

### Generation: 50 ###
🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 
🌿 🌿 🌿 🌿 🌿 👻 👻 👻 👻 👻 👻 🌿 🌿 🌿 🌿 🌿 
🌿 🌿 🌿 🌿 👻 🌿 🌿 🌿 🌿 🌿 🌿 👻 🌿 🌿 🌿 🌿 
🌿 🌿 🌿 👻 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 👻 🌿 🌿 🌿 
🌿 🌿 🌿 🌿 👻 🌿 🌿 🌿 🌿 🌿 🌿 👻 🌿 🌿 🌿 🌿 
🌿 🌿 🌿 🌿 🌿 👻 👻 👻 👻 👻 👻 🌿 🌿 🌿 🌿 🌿 
🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 🌿 
$ 
````

## 環境 / Environment
* UTF-8が使える端末 / A terminal for which UTF-8 encoding is enabled.
* bash (`clear`と`sleep`を使用しています / for using `clear` and `sleep` commands)
* Perl


