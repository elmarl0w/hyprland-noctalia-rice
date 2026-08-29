hl.config({
    dwindle = {
        preserve_split = true,
    },
    misc = {
        col = {
            splash = CACHYLGREEN,
        },
        middle_click_paste = false,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        -- 2 = адаптивная синхронизация в любом полноэкранном приложении.
        -- Режим 3 требовал от игры метки «игровой контент», которую под
        -- Proton ставят далеко не все, поэтому VRR почти не включался.
        vrr = 2,
    },
    xwayland = {
        force_zero_scaling = true
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})