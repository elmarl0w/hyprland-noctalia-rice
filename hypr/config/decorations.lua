-- Look and feel configuration
-- Цвета бордеров задаются в config/borders.lua (после темы Noctalia)

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 10,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
    },
    decoration = {
        rounding = 12,
        rounding_power = 2.2,
        dim_special = 0.35,
        -- окна непрозрачные: за прозрачность отвечает сам терминал
        active_opacity = 1.0,
        inactive_opacity = 0.94,
        fullscreen_opacity = 1.0,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            new_optimizations = true,
            xray = false,
            ignore_opacity = true,
            noise = 0.015,
            contrast = 1.05,
            brightness = 0.95,
            vibrancy = 0.25,
            vibrancy_darkness = 0.15,
            popups = true,
            popups_ignorealpha = 0.4,
            special = true,
        },
        shadow = {
            enabled = true,
            range = 24,
            render_power = 3,
            scale = 0.97,
            offset = "0 4",
        },
    },
})
