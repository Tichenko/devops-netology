* ДЗ к занятию «2.4. Инструменты Git»
* 1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea
* Ответ:  git show aefea
* commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
* Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
* Date:   Thu Jun 18 10:29:58 2020 -0400

*     Update CHANGELOG.md


* 2.Какому тегу соответствует коммит 85024d3?
* Ответ: $ git show 85024d3     ( v0.12.23)
 
* 3. Сколько родителей у коммита b8d720? Напишите их хеши.
* Ответ: git show --format="%P" 
* b8d72056cd7859e05c36c06b56d013b55a252d0bb7e158 
* 9ea88f22fc6269854151c571162c5bcf958bee2b

* 4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.
* Ответ: $ git log v0.12.23..v0.12.24 --oneline
* 33ff1c03bb (tag: v0.12.24) v0.12.24
* b14b74c493 [Website] vmc provider links
* 3f235065b9 Update CHANGELOG.md
* 6ae64e247b registry: Fix panic when server is unreachable
* 5c619ca1ba website: Remove links to the getting started guide's old location
* 06275647e2 Update CHANGELOG.md
* d5f9411f51 command: Fix bug when using terraform login on Windows
* 4b6d06cc5d Update CHANGELOG.md
* dd01a35078 Update CHANGELOG.md
* 225466bc3e Cleanup after v0.12.23 release

* 5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) 
* (вместо троеточия перечислены аргументы)
* Ответ: git log -S"func providerSource(" --oneline
* 8c928e8358 main: Consult local directories as potential mirrors of providers 

* 6. Найдите все коммиты в которых была изменена функция globalPluginDirs.
* Ответ: $ git log -S 'globalPluginDirs' --oneline
* 125eb51dc4 Remove accidentally-committed binary
* 22c121df86 Bump compatibility version to 1.3.0 for terraform core release (#30988)
* 35a058fb3d main: configure credentials from the CLI config file
* c0b1761096 prevent log output during init
* 8364383c35 Push plugin discovery down into command package

7. Кто автор функции synchronizedWriters?
* Ответ: git log -S 'synchronizedWriters' --oneline
* bdfea50cc8 remove unused
* fd4f7eb0b9 remove prefixed io
* 5ac311e2a9 main: synchronize writes to VT100-faker on Windows

* $ git log 5ac311e2a
* commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
* Author: Martin Atkins <mart@degeneration.co.uk>
* Date:   Wed May 3 16:25:41 2017 -0700

