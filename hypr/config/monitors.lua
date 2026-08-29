-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

-- "preferred" берёт частоту из EDID, а там часто 60 Гц, даже если
-- монитор умеет больше. "highrr" выбирает максимальную доступную
-- частоту и потому переносим на любое железо.
-- Список режимов конкретного монитора: hyprctl monitors all
hl.monitor({
    output    = MONITOR1,
    mode      = "highrr",
    position  = "auto",
    scale     = "auto",
    -- 10 бит на канал: меньше полос на градиентах, панель это заявляет в EDID
    bitdepth  = 10,
})
