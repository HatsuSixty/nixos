require("presence").setup({
    -- General options
    auto_update         = true,
    neovim_image_text   = "I use vim btw",
    main_image          = "neovim",
    log_level           = "error",
    buttons             = true,
    show_time           = true,

    -- Rich Presence text options
    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
})
