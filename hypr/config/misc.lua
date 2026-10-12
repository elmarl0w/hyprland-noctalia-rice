hl.config({
    dwindle = {
        preserve_split = true,
    },
    misc = {
        col = {
            splash = CACHYLGREEN,
        },
        -- вставка средней кнопкой из первичного выделения, как в большинстве дистрибутивов
        middle_click_paste = true,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        -- 3 = VRR только для окон с меткой игрового контента.
        -- Метку выставляет правило в windowrules.lua для класса
        -- ^(steam_app.*|gamescope)$, так что игры её получают.
        -- Режим 2 включал VRR в ЛЮБОМ полноэкранном окне (просмотрщик
        -- фото, видео), и на VA-матрице это давало мерцание подсветки.
        vrr = 3,
    },
    xwayland = {
        force_zero_scaling = true
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})