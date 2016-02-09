# scripts.sh
Some scripts on bash/sh

## * Идеи для ненужной фоторамки
Например, выводить слова из сборника *1700_TOEFL_Words*.

Скачаем. Переведем pdf в текст (сохраним переводы строк для удобной ориентации).

`pdftotext -layout <input.file> <output.file>`

Чтобы задавать границы sed`у для печати отдельных карточек, необходимо вывести в отдельный список "названия" слов.

`cat <file>| grep -e "^[A-Z]"| grep -e ")$" > words`

Разложим информацию про каждое слово в отдельный файл.

```
#!/bin/bash
lines=1684 # кол-во строк в файле со словами, куда-то подевалось 16 слов!!!
mkdir /tmp/voc
for i in `seq -w 1 $lines`
    do
        first=`sed -n "$i"p words`
        next=`expr $i + 1`
        second=`sed -n "$next"p words`
        cat <file>| sed -n "/${first}/,/${second}/p"| sed '$d' > /tmp/voc/$i.voc
done
```

Теперь сделаем из текста картинки для фоторамки (интересный параметр caption, с помощью которого imagemacgick пытается вместить текст в границы размеров картинки)
```
cd /tmp/voc
for i in `ls`
    do cat $i| convert -background white -fill black -font URW-Chancery-L-Medium-Italic -border 5 \
    -bordercolor white -size 480x234 -gravity NorthWest caption:@- $i.jpg; done
```
