# Hyprland + Noctalia rice

Конфигурация рабочего стола на **Hyprland** с шеллом **Noctalia**, где палитра всей
системы генерируется из обоев и разъезжается по терминалу, редактору, GTK/Qt,
бордерам окон и RGB-подсветке железа.

Сменил обои — перекрасилось всё, включая клавиатуру.

<!-- Скриншот: положи сюда своё изображение и раскомментируй
![screenshot](docs/screenshot.png)
-->

## Что входит

| Компонент | Файл |
|---|---|
| Hyprland (Lua-конфиг) | `hypr/` |
| Noctalia: бар, панели, локскрин | `noctalia/config.toml` |
| Фиксированная палитра CachyOS | `noctalia/palettes/CachyGreen.json` |
| kitty | `kitty/kitty.conf` |
| Neovim с нуля | `nvim/` |
| Синхронизация RGB-железа | `bin/noctalia-rgb-sync` |
| Сервис OpenRGB | `systemd/openrgb.service` |

## Требования

Базовая система — **CachyOS** (сборка с Hyprland) или Arch с уже настроенным
Hyprland. Конфиг Hyprland здесь в **Lua-формате**, а не `hyprland.conf`.

```bash
# обязательное
sudo pacman -S --needed noctalia hyprland kitty neovim

# RGB-подсветка (опционально)
sudo pacman -S --needed openrazer-driver-dkms openrazer-daemon python-openrazer openrgb
sudo gpasswd -a "$USER" openrazer   # группа называется openrazer, НЕ plugdev
```

После установки openrazer нужна перезагрузка — собирается модуль ядра.

## Установка

```bash
git clone https://github.com/elmarl0w/hyprland-noctalia-rice
cd hyprland-noctalia-rice
./install.sh
```

Установщик бэкапит существующие конфиги в `~/config-backup-<дата>` и подставляет
пути под твою систему (каталог обоев берётся из XDG).

## Как работает палитра

Ключевая настройка — в `noctalia/config.toml`:

```toml
[theme]
source = "wallpaper"
wallpaper_scheme = "vibrant"

[theme.templates]
builtin_ids = [ "btop", "gtk3", "gtk4", "kcolorscheme", "kitty", "qt", "alacritty", "hyprland" ]
community_ids = [ "neovim" ]
```

Noctalia извлекает цвета из обоев и рендерит шаблоны для каждого приложения.
Шаблон `hyprland` дописывает `require("noctalia").apply_theme()` в конец
`hyprland.lua` и красит бордеры окон.

### Схемы: названия обманчивы

Схема определяет, насколько сильно расходятся primary / secondary. Замерено на
одних и тех же обоях:

| схема | primary | secondary | разброс оттенков |
|---|---|---|---|
| `m3-tonal-spot` | `#a5c8fe` | `#bcc7dc` | 3° |
| `m3-rainbow` | `#a5c8ff` | `#bcc7dc` | 3° |
| `m3-fruit-salad` | `#4fd8ea` | `#81d3df` | 1° |
| `m3-content` | `#c4c6ce` | `#c7c6c9` | 32°, но обесцвеченные |
| **`vibrant`** | **`#67a3e4`** | **`#625cd6`** | **32°** |

Несмотря на имена, `rainbow` и `fruit-salad` дают монохром. Красочная — `vibrant`,
она здесь и стоит. Полный список: `m3-tonal-spot`, `m3-content`, `m3-rainbow`,
`m3-fruit-salad`, `m3-monochrome`, `vibrant`.

### Фиксированная палитра вместо обоев

Если не нужно, чтобы цвета прыгали:

```bash
noctalia msg color-scheme-set custom CachyGreen   # мятно-зелёный CachyOS
noctalia msg color-scheme-set wallpaper vibrant   # обратно к обоям
```

## Темизация приложений

Через community-шаблоны Noctalia палитру подхватывают ещё несколько программ:

```toml
[theme.templates]
community_ids = [ "neovim", "vscode", "obsidian", "opencode", "micro", "bat", "fastfetch", "telegram" ]
```

Проверь пути перед включением — часть шаблонов метит не туда, куда кажется:

- **vscode** — есть отдельные варианты для VS Code (`~/.vscode`), **Code-OSS/VSCodium**
  (`~/.vscode-oss`) и Antigravity. Нужный подхватывается автоматически по `requires_path`.
- **discord** — пишет в `vesktop`, официальный клиент так не темится.
- **steam** — требует предустановленного скина Material-Theme.
- **telegram** — кладёт `.tdesktop-theme`, но применить его нужно вручную внутри Telegram.

## Горячие клавиши

| | |
|---|---|
| `Super + Shift + W` | панель обоев |
| `Super + Space` | лаунчер |
| `Super + X` | центр управления |
| `Super + Z` | настройки Noctalia |
| `Super + L` | заблокировать экран |
| `Super + Tab` | переключатель окон |
| `Print` | скриншот области |

## RGB-подсветка

`bin/noctalia-rgb-sync` вешается на хук `colors_changed` и красит железо в акцент
палитры. Работает через сервер OpenRGB — он видит клавиатуру, материнку,
видеокарту и модули памяти разом.

**Почему именно сервер.** Прямой вызов `openrgb --mode direct --color X` сканирует
шину i2c и занимает под минуту — в хуке он молча не успевает. Сервер держит
устройства открытыми, запрос отрабатывает за ~1 секунду. Поэтому `openrgb.service`
и включается автозапуском.

Ручное управление — GUI командой `openrgb`. Чтобы свой цвет не затирался:

```bash
touch ~/.config/rgb-sync.off   # выключить синхронизацию
rm ~/.config/rgb-sync.off      # включить
```

Лог: `/tmp/rgb-sync.log`.

## Экран входа

`noctalia-greeter` показывает те же обои и палитру, что и рабочий стол. Он
работает через **greetd** и заменяет собой SDDM или другой дисплей-менеджер.

```bash
sudo pacman -S --needed greetd noctalia-greeter
# конфиг печатает сам пакет — не сочиняй его руками:
noctalia-greeter-print-greetd-config
```

Конфиг из `greetd/config.toml` в этом репозитории совпадает с тем, что выдаёт
генератор. Переключение:

```bash
sudo systemctl disable sddm
sudo systemctl enable greetd
reboot
```

**Держи откат под рукой.** Если greetd не стартует, графического входа не будет
вовсе — только TTY:

```bash
# Ctrl+Alt+F2, войти как root
systemctl disable --now greetd
systemctl enable --now sddm
reboot
```

Бинарь сессии называется `noctalia-greeter-session`, а не `noctalia-greeter` —
на этом легко споткнуться. Пользователю `greeter` нужен доступ к
`/var/lib/noctalia-greeter` (режим `750`, владелец `greeter:greeter`), а его
домашним каталогом должен быть тот же путь.

Внешний вид задаётся декларативно в `/var/lib/noctalia-greeter/greeter.toml` —
эти ключи имеют приоритет над синхронизацией и не перетираются ею. В
`5.0.0_beta.9` команда `noctalia msg greeter-sync` присутствует в справке, но
рабочим экземпляром не принимается, так что декларативный путь надёжнее.

### Не включай auto_sync

В `[shell.greeter_sync]` есть `auto_sync`. Со значением `true` Noctalia при каждой
смене палитры запускает `noctalia-greeter-apply-appearance` через `run0`, чтобы
записать файлы в `/var/lib/noctalia-greeter/` — и polkit требует пароль **каждый
раз**. Диалог при этом просит авторизацию на «запуск transient unit», а не на
действие гритера, потому что поднятие идёт через `run0`, а не через `pkexec`
с политикой пакета.

Правилом polkit это не лечится: разрешать `org.freedesktop.systemd1.manage-units`
без пароля — фактически беспарольный root, а имена transient-юнитов случайные
(`run-pNNN-iNNN`), так что сузить правило не получится.

Держи `auto_sync = false`, а внешний вид задавай декларативно в
`/var/lib/noctalia-greeter/greeter.toml` — эти ключи всё равно в приоритете над
синхронизацией.

## Обои

В репозитории их **нет** — это чужие работы. Взять можно:

- маскот CachyOS: пакет `cachyos-wallpapers`, серия `*NekoLady` в `/usr/share/wallpapers/`
- аниме-обои: [wallhaven](https://wallhaven.cc) — ищи по тегу **`OS-tan`**, это
  жанровое имя маскотов-девушек у дистрибутивов; поиск по цвету выдаёт пейзажи,
  а по тегу — то что нужно

Для ультраширокого монитора картинки 16:9 лучше кадрировать вручную: автоматический
`fill_mode = "crop"` режет по центру вслепую.

## Заметки по Noctalia

Документации по ключам конфига нет, поэтому:

```bash
noctalia config export full          # полная схема со всеми дефолтами
noctalia config export               # только твой текущий конфиг
noctalia config validate <файл>      # проверить, не трогая рабочий
```

`validate` ловит нераспознанные типы виджетов и переименованные ключи
(например `show_label` → `show_value`), но **не проверяет** значения `stat` и
enum'ов — их видно только глазами после применения.

Кастомные палитры кладутся в `~/.config/noctalia/palettes/<Name>.json` — плоско,
без подпапки.

Настройки живут в двух местах: `~/.config/noctalia/config.toml` — декларативный
пользовательский конфиг, `~/.local/state/noctalia/settings.toml` — рантайм.
Обои и выбор палитры пишутся во второй, через `noctalia msg`.

## Грабли

**Градиентный бордер.** Шаблон `hyprland` от Noctalia задаёт **плоский** цвет
бордера. Чтобы был градиент, `config/borders.lua` подключается **после**
`require("noctalia").apply_theme()` и читает цвета из `require("noctalia").colors`.
Порядок в `hyprland.lua` важен.

**Светлые капсулы.** Заливка `on_secondary` в некоторых палитрах оказывается
светлой, и текст на капсуле пропадает. Для нейтральных плашек используй
`surface_variant`.

**Neovim и treesitter.** Свежий `nvim-treesitter` переехал на новый API, модуля
`nvim-treesitter.configs` там больше нет. В `nvim/lua/plugins/init.lua` плагин
запинен на ветку `master`, где классический интерфейс жив.

**OpenRazer на Arch.** Группа называется `openrazer`, а не `plugdev` из
апстримной инструкции. Демон активируется по D-Bus при первом обращении, а
членство в группе вступает в силу только после перелогина — до перезагрузки
подсветка молча не работает.

**OpenRGB и Razer.** Сам по себе OpenRGB устройства Razer на Linux не видит —
он ходит к ним через демон OpenRazer. Нужны оба пакета.
