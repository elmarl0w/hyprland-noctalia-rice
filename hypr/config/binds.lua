-- ═══════════════════════════════════════════════════════════════
--  Раскладка сочетаний в стиле macOS.
--  Работает вместе с /etc/keyd/default.conf, который поворачивает
--  три клавиши нижнего ряда:
--
--     мизинец    Ctrl  -> SUPER   = ⌃ Control на маке
--     средняя    Super -> ALT     = ⌥ Option
--     у пробела  Alt   -> CONTROL = ⌘ Command
--
--  Поэтому ниже: CONTROL это ⌘, ALT это ⌥, SUPER это ⌃.
-- ═══════════════════════════════════════════════════════════════

local mainMod = "SUPER"            -- ⌃ мизинец: оконный менеджер
local cmd     = "CONTROL"          -- ⌘ большой палец: приложения
local opt     = "ALT"              -- ⌥ средняя
local noctCall = "noctalia msg "
local launchPrefix = "uwsm app -- "

---------------------------------
---- ПРИЛОЖЕНИЯ  (⌘ Command) ----
---------------------------------

hl.bind(cmd .. " + Space",          hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))
hl.bind(cmd .. " + Tab",            hl.dsp.exec_cmd(noctCall .. "window-switcher"))
hl.bind(cmd .. " + Q",              hl.dsp.window.close())
hl.bind(cmd .. " + comma",          hl.dsp.exec_cmd(noctCall .. "settings-toggle"))
hl.bind(cmd .. " + Return",         hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(cmd .. " + " .. opt .. " + Escape", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + " .. cmd .. " + Q",  hl.dsp.exec_cmd(noctCall .. "session lock"))

-- Скриншоты
hl.bind(cmd .. " + SHIFT + 3", hl.dsp.exec_cmd([[sh -c 'grim - | wl-copy']]))
hl.bind(cmd .. " + SHIFT + 4", hl.dsp.exec_cmd([[sh -c 'grim -g "$(slurp)" - | wl-copy']]))
hl.bind(cmd .. " + SHIFT + 5", hl.dsp.exec_cmd(noctCall .. "screenshot-region"))

-----------------------------------------
---- РАБОЧИЕ СТОЛЫ  (⌃ мизинцем)     ----
-----------------------------------------

for i = 1, NUM_WPM do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = "m~" .. i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = "m~" .. i }))
end

hl.bind(mainMod .. " + Right",         hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + Left",          hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + Down",          hl.dsp.focus({ workspace = "emptym" }))
hl.bind(mainMod .. " + Up",            hl.dsp.exec_cmd(noctCall .. "window-switcher"))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ workspace = "m-1" }))

-- Колесом мыши
hl.bind(mainMod .. " + mouse_down",         hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + mouse_up",           hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.window.move({ workspace = "m-1" }))

-- Карман
hl.bind(mainMod .. " + " .. opt .. " + S", hl.dsp.workspace.toggle_special())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))

------------------------------------
---- ТАЙЛИНГ  (⌃ + буквы vim)   ----
------------------------------------

-- Направление: ⌃⌥ + стрелки. Буквы отданы терминалу под управляющие коды.
hl.bind(mainMod .. " + " .. opt .. " + Left",  hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + " .. opt .. " + Down",  hl.dsp.focus({ direction = "down"  }))
hl.bind(mainMod .. " + " .. opt .. " + Up",    hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + " .. opt .. " + Right", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + " .. opt .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + " .. opt .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + " .. opt .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + " .. opt .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))

hl.bind(mainMod .. " + SHIFT + F",          hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + D",          hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + " .. opt .. " + F",  hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Tab",                hl.dsp.layout("togglesplit"))

-- Мышью
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

--------------------------
---- ЗАПУСК ПРОГРАММ ----
--------------------------

hl.bind(mainMod .. " + " .. opt .. " + E", hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
hl.bind(mainMod .. " + " .. opt .. " + W", hl.dsp.exec_cmd(launchPrefix .. BROWSER))
hl.bind(mainMod .. " + " .. opt .. " + T", hl.dsp.exec_cmd(launchPrefix .. EDITOR))
-- ⌃C отдан терминалу под сигнал прерывания; калькулятор — через лаунчер
hl.bind(mainMod .. " + " .. opt .. " + V", hl.dsp.exec_cmd(noctCall .. "panel-toggle clipboard"))
hl.bind(mainMod .. " + " .. opt .. " + A", hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center notifications"))
hl.bind(mainMod .. " + " .. opt .. " + X", hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center"))
hl.bind(mainMod .. " + " .. opt .. " + P", hl.dsp.exec_cmd("hyprpicker -a -n"))
hl.bind(mainMod .. " + period",    hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher /emo"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(noctCall .. "panel-toggle wallpaper"))
hl.bind(mainMod .. " + " .. opt .. " + C", hl.dsp.exec_cmd(noctCall .. "panel-toggle session"))
hl.bind(mainMod .. " + SHIFT + Escape",    hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e btop"))

---------------------------
---- АППАРАТНЫЕ КЛАВИШИ ----
---------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume-up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(noctCall .. "volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(noctCall .. "mic-mute"),    { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd(noctCall .. "media toggle"), { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd(noctCall .. "media toggle"), { locked = true })
hl.bind("Print",                hl.dsp.exec_cmd(noctCall .. "screenshot-region"))
