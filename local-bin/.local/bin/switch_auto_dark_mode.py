#!/usr/bin/env python3.10

import asyncio
import iterm2

async def changeTheme(theme_parts, connection):
    # Themes have space-delimited attributes, one of which will be light or dark.
    if "dark" in theme_parts:
        preset = await iterm2.ColorPreset.async_get(connection, "Dracula Pro")
    else:
        preset = await iterm2.ColorPreset.async_get(connection, "catppuccin-latte")

    # Update the list of all profiles and iterate over them.
    profiles=await iterm2.PartialProfile.async_query(connection)
    for partial in profiles:
        # Fetch the full profile and then set the color preset in it.
        profile = await partial.async_get_full_profile()
        await profile.async_set_color_preset(preset)

async def main(connection):
    # Set color scheme correctly at app start
    app = await iterm2.async_get_app(connection)
    parts = await app.async_get_theme()
    await changeTheme(parts, connection)


    async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
        while True:
            # Block until theme changes
            theme = await mon.async_get()
            parts = theme.split(" ")
            await changeTheme(parts, connection)

iterm2.run_forever(main)

# import asyncio
# import iterm2

# async def main(connection):
#     async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
#         while True:
#             # Block until theme changes
#             theme = await mon.async_get()

#             # Themes have space-delimited attributes, one of which will be light or dark.
#             parts = theme.split(" ")
#             if "dark" in parts:
#                 preset = await iterm2.ColorPreset.async_get(connection, "Dracula Pro")
#             else:
#                 preset = await iterm2.ColorPreset.async_get(connection, "catppuccin-latte")

#             # Update the list of all profiles and iterate over them.
#             profiles=await iterm2.PartialProfile.async_query(connection)
#             for partial in profiles:
#                 # Fetch the full profile and then set the color preset in it.
#                 profile = await partial.async_get_full_profile()
#                 await profile.async_set_color_preset(preset)

# iterm2.run_forever(main)