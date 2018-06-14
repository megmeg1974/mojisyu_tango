# mojisyu_tango
某大学の講義で出されたレポート課題の解決を支援するツール。
- レポート課題:《日本語の単語で、文字の種類(漢字、ひらがな、カタカナ、数字、アルファベット、etc)を4種類以上含むものを列挙せよ》
- 上記課題に対応するため、[Wikipedia日本語版](https://ja.wikipedia.org/wiki/メインページ)の記事タイトルを単語とみなし、記事タイトルの中から4種以上の文字を含むものを抽出する。

## 使い方

1. [Index of /jawiki/](https://dumps.wikimedia.org/jawiki/)から、リンクをたどって、[Wikipedia日本語版](https://ja.wikipedia.org/wiki/メインページ)の記事タイトル一覧ファイルをダウンロードする。
    - [jawiki-20180601-pages-articles-multistream-index.txt.bz2](https://dumps.wikimedia.org/jawiki/20180601/jawiki-20180601-pages-articles-multistream-index.txt.bz2)などの名前のファイルを一つ落とせばよい。
2. 下記のコマンドを実行すると、抽出結果がテキストファイル`sel.txt`に作成される。[^1]
```bash
bzcat sample/jawiki-20180601-pages-articles-multistream-index.txt.bz2 \
| ./sel.pl \
| sort -t: -nk1,2 \
> sel.txt
```
3. 下記の出力結果を得る。ただし、コロン(`:`)の前の数字は文字数。
```
[~/doc/mojisyu_tango]
$ head -6 sel.txt
4:3D酔い
4:8時だJ
4:G1通り
4:G2通り
4:V6の素
5:3時ヨこい
[~/doc/mojisyu_tango]
$ tail -3 sel.txt
101:『愛 am BEST Tour 2007 〜ベストなコメントにめっちゃ愛を込めんと!!!〜』at Tokyo International Forum Hall A on 9th of July 2007
119:「the last day of syrup16g」syrup16g最後の日 The complete document of LIVE FOREVER 〜the last waltz of syrup16g〜 live at 日本武道館
127:TBS系ドラマ「花嫁は厄年ッ!」Original Soundtrack - SUITE Of &quot;Unlucky Year for the Bride&quot; - Presented by SUEMITSU &amp; THE SUEMITH
[~/doc/mojisyu_tango]
$
```


[^1]:`sample/jawiki-20180601-pages-articles-multistream-index.txt.bz2`の部分は、ダウンロードしたファイル名を記述する。
