-- Градиентный бордер поверх плоских цветов темы Noctalia.
-- Подключается ПОСЛЕ require("noctalia").apply_theme(), поэтому переопределяет её.

-- Тянем акцент из сгенерённой Noctalia палитры, с откатом на цвета CachyOS.
local ok, noctalia = pcall(require, "noctalia")
local accent   = (ok and noctalia.colors and noctalia.colors.primary)   or CACHYLGREEN
local accent2  = (ok and noctalia.colors and noctalia.colors.secondary) or CACHYDGREEN
local inactive = (ok and noctalia.colors and noctalia.colors.surface)   or CACHYGRAY

hl.config({
    general = {
        col = {
            active_border = {
                colors = { accent, accent2 },
                angle = 45,
            },
            inactive_border = inactive,
        },
    },
})
